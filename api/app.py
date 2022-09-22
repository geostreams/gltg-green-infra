import config

# Get the application instance
connex_app = config.connexion_app

# Read the swagger.yml file to configure the endpoints
connex_app.add_api('v1.0.yml')

if __name__ == "__main__":
    connex_app.run(port=5000, debug= True)
