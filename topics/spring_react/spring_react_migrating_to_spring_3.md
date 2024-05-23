---
parent: "Spring/React"
grand_parent: Topics
layout: default
title: "Spring/React: Migrating to Spring 3"
description:  "Guide for migrating CS156 Spring/React apps from Spring 2 to Spring 3"
category_prefix: "Spring React: "
indent: true
---

# {{page.title}}

## {{page.description}}

All of the Spring/React legacy code apps used in CMPSC 156 that were started in S24 or earlier used Spring 2.

At a certain point, it became imperative to move to Spring 3 because some of the dependencies of the old stack had security vulnerabilities, and the updated versions that fixed the vulnerabilities only worked with Spring 3.

This page describes the changes you need to make to a legacy Spring 2 app that uses the set of dependencies and code conventions associated with CMPSC 156 Spring/React apps.

* <https://github.com/ucsb-cs156-f24/STARTER-team03/pull/13>

### Update dependencies

In `pom.xml`, update the following dependencies to their latest compatible version. A compatible version shares the same major # and a minimum minor # as below. For more information, see <https://semver.org>. You can explore dependencies' versions at <https://mvnrepository.com>.

| Dependency                                            | Version | Notes                                         |
| ----------------------------------------------------- | ------- | --------------------------------------------- |
| `org.springframework.boot:spring-boot-starter-parent` | `^3.1`  |                                               |
| `org.springframework.cloud:spring-cloud-gateway-mvc`  | `^4.1`  |                                               |
| `org.springdoc:springdoc-openapi-starter-webmvc-ui`   | `^2.5`  | Replaces `org.springdoc:springdoc-openapi-ui` |

### Jakarta vs. Javax

Beginning with Java 9, many `javax`-namespaced libraries have been moved to the `jakarta` namespace. Generally speaking, if the compiler complains that a class can't be found in `javax`, try importing it from `jakarta`.

### Security Config

Spring Boot 3 overhauled the old method of configuring various security settings. For a full description of how to refactor your code, see <https://spring.io/blog/2022/02/21/spring-security-without-the-websecurityconfigureradapter>. Here are the changes we made in the team03 project:

- Use `EnableGlobalMethodSecurity`
  
```diff
- @EnableGlobalMethodSecurity(prePostEnabled = true)
+ @EnableMethodSecurity
```

- Do not extend `WebSecurityConfigurerAdapter`

```diff
- public class SecurityConfig extends WebSecurityConfigurerAdapter {
+ public class SecurityConfig {
```

- Replace the `HttpSecurity` configurer with a `SecurityFilterChain` bean (note CSRF changes)

```diff
- @Override
- protected void configure(HttpSecurity http) throws Exception {
-   http.authorizeRequests(authorize -> authorize
-       .anyRequest().permitAll())
-       .exceptionHandling(handlingConfigurer -> handlingConfigurer
-           .authenticationEntryPoint(new Http403ForbiddenEntryPoint()))
-       .oauth2Login(
-           oauth2 -> oauth2.userInfoEndpoint(userInfo -> userInfo.userAuthoritiesMapper(this.userAuthoritiesMapper())))
-       .csrf(csrf -> csrf
-           .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()))
-       .logout(logout -> logout
-           .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
-           .logoutSuccessUrl("/"));
- }
+ @Bean
+ public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
+   http
+       .exceptionHandling(handling -> handling.authenticationEntryPoint(new Http403ForbiddenEntryPoint()))
+       .oauth2Login(
+           oauth2 -> oauth2.userInfoEndpoint(userInfo -> userInfo.userAuthoritiesMapper(this.userAuthoritiesMapper())))
+       .csrf(csrf -> csrf
+           .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
+           .csrfTokenRequestHandler(new SpaCsrfTokenRequestHandler()))
+       .addFilterAfter(new CsrfCookieFilter(), BasicAuthenticationFilter.class)
+       .authorizeHttpRequests(auth -> auth.anyRequest().permitAll())
+       .logout(logout -> logout.logoutRequestMatcher(new AntPathRequestMatcher("/logout")).logoutSuccessUrl("/"));
+   return http.build();
+ }
```

- Replace the `WebSecurity` configurer with a `WebSecurityCustomizer` bean

```diff
- @Override
- public void configure(WebSecurity web) throws Exception {
-   web.ignoring().antMatchers("/h2-console/**");
- }
+ @Bean
+ public WebSecurityCustomizer webSecurityCustomizer() {
+   return web -> web.ignoring().requestMatchers("/h2-console/**");
+ }
```

- Add CSRF token distribution

```diff
+ final class SpaCsrfTokenRequestHandler extends CsrfTokenRequestAttributeHandler {
+   private final CsrfTokenRequestHandler delegate = new XorCsrfTokenRequestAttributeHandler();
+ 
+   @Override
+   public void handle(HttpServletRequest request, HttpServletResponse response,
+       Supplier<CsrfToken> deferredCsrfToken) {
+     /*
+     * Always use XorCsrfTokenRequestAttributeHandler to provide BREACH protection
+     * of
+     * the CsrfToken when it is rendered in the response body.
+     */
+     this.delegate.handle(request, response, deferredCsrfToken);
+   }
+ 
+   @Override
+   public String resolveCsrfTokenValue(HttpServletRequest request, CsrfToken csrfToken) {
+     /*
+     * If the request contains a request header, use
+     * CsrfTokenRequestAttributeHandler
+     * to resolve the CsrfToken. This applies when a single-page application
+     * includes
+     * the header value automatically, which was obtained via a cookie containing
+     * the
+     * raw CsrfToken.
+     */
+     if (StringUtils.hasText(request.getHeader(csrfToken.getHeaderName()))) {
+       return super.resolveCsrfTokenValue(request, csrfToken);
+     }
+     /*
+     * In all other cases (e.g. if the request contains a request parameter), use
+     * XorCsrfTokenRequestAttributeHandler to resolve the CsrfToken. This applies
+     * when a server-side rendered form includes the _csrf request parameter as a
+     * hidden input.
+     */
+     return this.delegate.resolveCsrfTokenValue(request, csrfToken);
+   }
+ }
+ 
+ final class CsrfCookieFilter extends OncePerRequestFilter {
+   @Override
+   protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
+       throws ServletException, IOException {
+     CsrfToken csrfToken = (CsrfToken) request.getAttribute("_csrf");
+     // Render the token value to a cookie by causing the deferred token to be loaded
+     csrfToken.getToken();
+     filterChain.doFilter(request, response);
+   }
+ }
```

- Update `application-integration.properties` and `application-wiremock.properties`

```diff
- spring.security.oauth2.client.registration.my-oauth-provider.client-authentication-method=basic
```

### Tests

- Fix abstract class mocks

```diff
- CurrentUserService currentUserService = mock(CurrentUserService.class);
+ CurrentUserService currentUserService = mock(CurrentUserService.class, Answers.CALLS_REAL_METHODS);
```

- The `SecurityConfig` was no longer being pulled into tests automatically

```diff
@TestConfiguration
+ @Import(SecurityConfig.class)
public class TestConfig {
```

- `LocalServerPort` was re-namespaced

```diff
- import org.springframework.boot.web.server.LocalServerPort;
+ import org.springframework.boot.test.web.server.LocalServerPort;
```