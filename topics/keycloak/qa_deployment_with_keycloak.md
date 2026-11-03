---
parent: Keycloak
grand_parent: Topics
layout: default
title: "Set Up a QA Deployment With Keycloak"
description:  "directions for a QA deployment with Keycloak"
---

## Deploying a QA App with Keycloak
This guide assumes you're following the overall steps [here](https://ucsb-cs156.github.io/topics/dokku/deploying_an_app.html) to deploy an app.

When you get to setting environmental variables, you will additionally need to set a couple extra. In the following commands, swap `<app-name>` for your app's name.

The values should be provided to you for `KEYCLOAK_CLIENT_ID` and `KEYCLOAK_CLIENT_SECRET` by course staff.

```bash
dokku config:set --no-restart <app-name> KEYCLOAK_ISSUER_URI=https://keycloak-qa.dokku-00.cs.ucsb.edu/realms/cs156-qa
dokku config:set --no-restart <app-name> KEYCLOAK_CLIENT_ID=<provided-value>
dokku config:set --no-restart <app-name> KEYCLOAK_CLIENT_SECRET=<provided-value>
dokku config:set --no-restart <app-name> QA=true
```

This will provide the necessary credentials for your app for it to interface with keycloak. QA mode informs the app that it should enable this functionality.

<details markdown="1">
<summary markdown="1">

### Need to issue Keycloak credentials? Look here.
</summary>

1. Sign into the appropriate keycloak realm here: <https://keycloak-qa.dokku-00.cs.ucsb.edu/admin/cs156-qa/console/>
2. Select "Clients":
<img width="1280" height="720" alt="image" src="https://github.com/user-attachments/assets/5a8edcd2-2951-4074-8e36-24f1906f95fb" />
3. Select "Create Client":
<img width="948" height="276" alt="image" src="https://github.com/user-attachments/assets/853cb080-6373-4260-a2a0-ed5533576e27" />
4. Fill in a client id-this is one students will use, so pick something memorable. Write it down for later.:
<img width="1280" height="720" alt="image" src="https://github.com/user-attachments/assets/37eb3069-0f8f-4763-a150-278180800ec5" />
5. Select "Next"
6. Enable "Client Authentication" and "Standard Flow". Everything else should be off:
<img width="1405" height="793" alt="image" src="https://github.com/user-attachments/assets/28aa00a4-fdce-4b4c-82dd-a94603561237" />
7. Select "Next"
 
8. For "Valid Redirect URIs", fill in the appropriate wildcard or domain. For this example, I'm going to use `https://*.dokku-00.cs.ucsb.edu/login/oauth2/code/keycloak`. As a note **it must end in `/login/oauth2/code/keycloak`**. This is the callback URI configured by us and used by Spring Security.
**Wildcards should not be used for the dokku-00 production applications and realm.**
<img width="1280" height="946" alt="image" src="https://github.com/user-attachments/assets/36eebe09-c247-4071-a862-b15512f822f6" />
9. Select "Save"

10. Select "Credentials", and copy the Client Secret. 
<img width="1764" height="985" alt="image" src="https://github.com/user-attachments/assets/3fda9a66-2bf9-428b-bf26-632883e246d0" />

From here, provide the values from Step 4 and Step 10 as `KEYCLOAK_CLIENT_ID` and `KEYCLOAK_CLIENT_SECRET`.
</details>
