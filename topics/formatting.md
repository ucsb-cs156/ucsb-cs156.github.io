---
parent: Topics
layout: default
title: "Formatting"
description: "How to use the formatting tools in our projects"
---

# {{page.title}}

In some projects, we enforce a formatting standard using
[Google java format](https://github.com/google/google-java-format) for Java and [Prettier](http://prettier.io) for
JavaScript.

This article provides help for working with these formatters in your own workspaces.

## Auto-formatting files from the command line

For Google Java Format:

- Run `mvn git-code-format:format-code` in the java src directory to format java files.

For Prettier:

- Run `npm run format` in the frontend directory to format js files.

## Auto-formatting plugins for IDEs

You can setup your IDE's auto-formatter to matter to match the formatting standard.

### Vscode

For Google java format:

- Install the "Extension Pack for Java".
- Open your `settings.json`: from the command pallet (Ctrl-shift-P), search for "Open workspace settings (JSON)"
- Add the following item to your
  json: `"java.format.settings.url": "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"`

For more info, see <https://code.visualstudio.com/docs/java/java-linting#_applying-formatter-settings>

For Prettier:

- Install the "Prettier - Code formatter" extension.
- When you next format a JS file, it may ask you to configure your default formatter. Select "Prettier"
- You can default formatter for JS files later by doing the following.
    - Open any JS file.
    - Open the command pallet (Ctrl-Shift-P) and search for "Format document with..."
    - Select "Configure default formatter".

### Jetbrains IDEs (Intellij idea, Webstorm, Etc.)

For Google java format:

- Install the "Google java format" plugin.
- Follow the additional configuration
  instructions [here](https://github.com/google/google-java-format/blob/master/README.md#intellij-jre-config).
- In settings, search for "google-java-format" and enable formatting for the project.

For Prettier:

- Install the "Prettier" plugin
- In settings, search for "prettier", and make sure prettier is enabled and configured properly. You may need to
  run `npm install` first.
