#!/bin/bash

# --- Global variable to store apps to be imported ---
OPTIONAL_APPS=""
OPTIONAL_MIDDLEWARE=""
OPTIONAL_CONTEXT_PROCESSORS=""
OPTIONAL_TEMPLATE_BACKENDS=""

# --- Function to display a welcome message and instructions ---
display_intro() {
    echo "=========================================="
    echo " Django Project Creation Script "
    echo "=========================================="
    echo "This script will guide you through setting up a new Django project."
    echo ""
}

# --- Function to get the project name ---
get_project_name() {
    read -p "Enter the name for your new Django project: " project_name
    if [ -z "$project_name" ]; then
        echo "Project name cannot be empty. Please try again."
        get_project_name
    fi
}

# --- Function to install optional libraries and track them ---
install_optional_libraries() {
    echo ""
    echo "-----------------------------------------"
    echo " Optional Libraries"
    echo "-----------------------------------------"
    echo "Select common libraries to install (y/n):"
    
    # Common Tools & Core Functionality
    read -p "Install Django REST Framework (DRF)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install djangorestframework
        OPTIONAL_APPS+="'rest_framework',\n"
    fi
    
    read -p "Install Django Debug Toolbar? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-debug-toolbar
        OPTIONAL_APPS+="'debug_toolbar',\n"
        OPTIONAL_MIDDLEWARE+="'debug_toolbar.middleware.DebugToolbarMiddleware',\n"
    fi
    
    read -p "Install Django Allauth (user auth)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-allauth
        OPTIONAL_APPS+="'allauth',\n"
        OPTIONAL_APPS+="'allauth.account',\n"
        OPTIONAL_APPS+="'allauth.socialaccount',\n"
    fi

    read -p "Install Django Extensions (extra commands)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-extensions
        OPTIONAL_APPS+="'django_extensions',\n"
    fi
    
    read -p "Install Django CORS Headers? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-cors-headers
        OPTIONAL_APPS+="'corsheaders',\n"
        OPTIONAL_MIDDLEWARE+="'corsheaders.middleware.CorsMiddleware',\n"
    fi

    read -p "Install Django Filter (API filtering)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-filter
        OPTIONAL_APPS+="'django_filter',\n"
    fi

    read -p "Install Celery (async tasks)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install celery
        pip install redis # Celery needs a message broker
        echo "Note: Celery requires a message broker like Redis. Redis has been installed."
    fi

    read -p "Install Django Channels (WebSockets)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install channels
        OPTIONAL_APPS+="'channels',\n"
    fi
    
    read -p "Install Django Crispy Forms? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-crispy-forms
        pip install crispy-bootstrap5
        OPTIONAL_APPS+="'crispy_forms',\n"
        OPTIONAL_APPS+="'crispy_bootstrap5',\n"
    fi

    read -p "Install Django Storages (for S3, etc.)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-storages
    fi
    
    read -p "Install Django Import-Export? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-import-export
        OPTIONAL_APPS+="'import_export',\n"
    fi
    
    read -p "Install Django TinyMCE (rich text editor)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-tinymce
        OPTIONAL_APPS+="'tinymce',\n"
    fi
    
    read -p "Install Django Guardian (per-object permissions)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-guardian
        OPTIONAL_APPS+="'guardian',\n"
    fi
    
    read -p "Install Pandas (data analysis)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install pandas
    fi

    read -p "Install Pillow (image processing)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install Pillow
    fi
    
    read -p "Install psycopg2-binary (PostgreSQL adapter)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install psycopg2-binary
    fi
    
    read -p "Install Gunicorn (WSGI server)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install gunicorn
    fi

    read -p "Install Whitenoise (static file serving)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install whitenoise
        OPTIONAL_MIDDLEWARE+="'whitenoise.middleware.WhiteNoiseMiddleware',\n"
    fi
    
    read -p "Install Wagtail CMS? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install wagtail
        OPTIONAL_APPS+="'wagtail.contrib.forms',\n"
        OPTIONAL_APPS+="'wagtail.contrib.redirects',\n"
        OPTIONAL_APPS+="'wagtail.embeds',\n"
        OPTIONAL_APPS+="'wagtail.sites',\n"
        OPTIONAL_APPS+="'wagtail.users',\n"
        OPTIONAL_APPS+="'wagtail.snippets',\n"
        OPTIONAL_APPS+="'wagtail.documents',\n"
        OPTIONAL_APPS+="'wagtail.images',\n"
        OPTIONAL_APPS+="'wagtail.search',\n"
        OPTIONAL_APPS+="'wagtail.admin',\n"
        OPTIONAL_APPS+="'wagtail',\n"
    fi
    
    read -p "Install Sentry-SDK (error tracking)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install sentry-sdk
    fi
    
    read -p "Install Djoser (API authentication)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install djoser
        OPTIONAL_APPS+="'djoser',\n"
    fi
    
    read -p "Install Django Haystack (search)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-haystack
        OPTIONAL_APPS+="'haystack',\n"
    fi

    read -p "Install Django CKEditor (rich text editor)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-ckeditor
        OPTIONAL_APPS+="'ckeditor',\n"
    fi
    
    read -p "Install Django-environ (manage .env files)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-environ
    fi

    read -p "Install Django-rest-swagger (API docs)? (y/n) " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        pip install django-rest-swagger
        OPTIONAL_APPS+="'rest_framework_swagger',\n"
    fi
}

# --- Function to set up GitHub ---
setup_github() {
    echo ""
    read -p "Do you want to create a GitHub repository for this project? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if ! command -v gh &> /dev/null; then
            echo "GitHub CLI 'gh' is not installed or not in your PATH. Skipping GitHub setup."
            echo "Please install and authenticate with 'gh' to use this feature."
            return
        fi

        # Prompt for repository visibility
        read -p "Do you want to make the repository private? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            VISIBILITY="--private"
        else
            VISIBILITY="--public"
        fi

        echo "Initializing Git repository..."
        git init -b main

        # Create a README.md file
        echo "# $project_name" > README.md
        echo "## Django Project" >> README.md
        
        # Add a basic .gitignore for common Django files
        echo "# Byte-compiled files" > .gitignore
        echo "__pycache__/" >> .gitignore
        echo "*.pyc" >> .gitignore
        echo "" >> .gitignore
        echo "# Environment variables" >> .gitignore
        echo "venv/" >> .gitignore
        echo ".env" >> .gitignore
        
        # Add files and commit
        git add .
        git commit -m "Initial project setup"

        # Create the remote repository on GitHub with specified visibility
        echo "Creating remote repository on GitHub..."
        gh repo create "$project_name" "$VISIBILITY" --source=. --push
        if [ $? -eq 0 ]; then
            echo "Successfully created and pushed to GitHub repository: https://github.com/$(gh api user --jq .login)/$project_name"
        else
            echo "Failed to create GitHub repository. Please check your GitHub CLI authentication."
        fi
    fi
}

# --- Main script execution ---
main() {
    display_intro

    get_project_name
    
    # Create the project directory
    echo "Creating project directory '$project_name'..."
    mkdir "$project_name"
    cd "$project_name"
    
    # Set up the virtual environment
    echo "Setting up a Python virtual environment..."
    python3 -m venv venv
    
    # Activate the virtual environment
    echo "Activating the virtual environment..."
    source venv/bin/activate
    
    # Install Django and other basic requirements
    echo "Installing Django..."
    pip install Django
    
    # Install optional libraries based on user input
    install_optional_libraries
    
    # Create a requirements.txt file
    echo "Generating requirements.txt..."
    pip freeze > requirements.txt
    
    # Start the new Django project
    echo "Starting the Django project..."
    django-admin startproject "$project_name" .
    
    # Setup GitHub optionally
    setup_github
    
    # Final messages
    echo ""
    echo "=========================================="
    echo " Project Setup Complete! "
    echo "=========================================="
    
    if [ -n "$OPTIONAL_APPS" ]; then
        echo "To configure your new project, copy and paste the following lines"
        echo "into the **INSTALLED_APPS** list in your **settings.py** file:"
        echo ""
        echo -e "    # --- Optional Apps from script ---\n${OPTIONAL_APPS}    # --- End Optional Apps ---"
        echo ""
    fi
    
    if [ -n "$OPTIONAL_MIDDLEWARE" ]; then
        echo "You also need to add the following lines to your **MIDDLEWARE** list:"
        echo ""
        echo -e "    # --- Optional Middleware from script ---\n${OPTIONAL_MIDDLEWARE}    # --- End Optional Middleware ---"
        echo ""
    fi
    
    if [ -n "$OPTIONAL_CONTEXT_PROCESSORS" ]; then
        echo "You also need to add the following lines to your **TEMPLATES** context processors list:"
        echo ""
        echo -e "    # --- Optional Context Processors from script ---\n${OPTIONAL_CONTEXT_PROCESSORS}    # --- End Optional Context Processors ---"
        echo ""
    fi
    
    echo "To get started, navigate into your new project directory and activate the virtual environment:"
    echo " cd $project_name"
    echo " source venv/bin/activate"
    echo " "
    echo "You can now run 'python manage.py runserver' to start your development server."
    echo "Happy coding! 💻"
    echo "=========================================="
    
    # Clean up
    deactivate
}

# Run the main function
main