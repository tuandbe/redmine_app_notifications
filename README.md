# Redmine App Notifications

This plugin provides simple in-app notifications for Redmine, which can serve as an alternative to the default e-mail notifications. This version has been tested with Redmine 5.x.

## 1. Standard Plugin Installation

1.  Follow the standard Redmine plugin installation steps:
    *   Copy the `redmine_app_notifications` directory into your Redmine `plugins` folder.
2.  Run the database migrations from your Redmine root directory:
    ```bash
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production
    ```
    *(Use `RAILS_ENV=development` for a development setup)*
3.  Restart your Redmine web server.

## 2. Running the Faye Server with Docker (Recommended)

This plugin requires a Faye real-time messaging server. We provide a simple, cross-platform Docker setup to run it, which is highly recommended for both development and production.

### Prerequisites

*   [Docker](https://www.docker.com/get-started) and Docker Compose are installed on your system.

### How to Run

A utility script is provided to easily manage the Faye Docker container. All commands should be run from this plugin's root directory (`plugins/redmine_app_notifications`).

1.  **Build the Docker image:**
    *(This only needs to be done once, or when you change the `Gemfile` or `Dockerfile.faye`)*
    ```bash
    ./scripts/start-faye.sh build
    ```

2.  **Start the Faye server:**
    *(This will run the server in the background)*
    ```bash
    ./scripts/start-faye.sh start
    ```

### Managing the Server

You can manage the server using the same script:

*   **Check the status:**
    ```bash
    ./scripts/start-faye.sh status
    ```
*   **View real-time logs:**
    ```bash
    ./scripts/start-faye.sh logs
    ```
*   **Stop the server:**
    ```bash
    ./scripts/start-faye.sh stop
    ```
*   **Restart the server:**
    ```bash
    ./scripts/start-faye.sh restart
    ```

The Faye server will be available at `http://localhost:9292/faye`.

## 3. Plugin Configuration

Once the plugin is installed and the Faye server is running, you need to configure Redmine to use it.

1.  Log in to Redmine as an administrator.
2.  Navigate to **Administration > Plugins**.
3.  Find **Redmine App Notifications** in the list and click **Configure**.
4.  Set the **Faye Server Address** to the URL of your running Faye container. If you are running Redmine and the Faye container on the same machine, this will be:
    ```
    http://localhost:9292/faye
    ```
    *Note: If your Redmine instance is running inside another Docker container on the same Docker network, you might need to use the container name as the hostname (e.g., `http://redmine_faye_server:9292/faye`).*
5.  Save the configuration.

## 4. User Preferences

Each user must enable in-app notifications in their personal settings:

1.  Click on your user name in the top-right corner and go to **My account**.
2.  Switch to the **Preferences** tab.
3.  Check the box for **Enable In App Notifications**.
4.  Save your preferences.
