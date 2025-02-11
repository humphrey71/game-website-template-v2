@echo off
echo Starting project initialization...

REM Store the current directory
set CURRENT_DIR=%CD%

REM Check if GitHub token is configured
git config --global --get github.token > nul
if %errorlevel% neq 0 (
    echo GitHub token not found. Please set it using:
    echo git config --global github.token YOUR_TOKEN
    echo You can create a token at https://github.com/settings/tokens
    echo Required permissions: repo
    exit /b 1
)

REM Get current directory name and GitHub token
for %%I in ("%CURRENT_DIR%") do set REPO_NAME=%%~nxI
for /f "tokens=*" %%a in ('git config --global github.token') do set GITHUB_TOKEN=%%a

REM Create private repository on GitHub
echo Creating private repository on GitHub: %REPO_NAME%
curl -X POST -H "Authorization: token %GITHUB_TOKEN%" -H "Accept: application/vnd.github.v3+json" https://api.github.com/user/repos -d "{\"name\":\"%REPO_NAME%\",\"private\":true}"
if %errorlevel% neq 0 (
    echo Failed to create repository
    exit /b %errorlevel%
)
timeout /t 5 /nobreak > nul

REM Change to the project directory
echo Changing to project directory...
cd "%CURRENT_DIR%"

REM Clone template branch to current directory
echo Step 1: Cloning template repository...
git clone -b template https://github.com/humphrey71/game-website-template-v2.git "%CURRENT_DIR%"
if %errorlevel% neq 0 (
    echo Failed to clone repository
    exit /b %errorlevel%
)

REM Rename remote to template
echo Step 2: Renaming remote to template...
git remote rename origin template
if %errorlevel% neq 0 (
    echo Failed to rename remote
    exit /b %errorlevel%
)

REM Create dev branch
echo Step 3: Creating dev branch...
git checkout template
git checkout -b dev
if %errorlevel% neq 0 (
    echo Failed to create dev branch
    exit /b %errorlevel%
)

REM Update package.json with new project name
echo Step 4: Updating package.json...
powershell -Command "(Get-Content package.json) -replace '\"name\": \"website-template\"', '\"name\": \"%REPO_NAME%\"' | Set-Content package.json"

REM Add and commit files
echo Step 5: Adding and committing files...
git add .
git commit -m "Initial commit from template"
if %errorlevel% neq 0 (
    echo Failed to commit files
    exit /b %errorlevel%
)

REM Create main branch from dev
echo Step 6: Creating main branch from dev...
git checkout dev
git checkout -b main
if %errorlevel% neq 0 (
    echo Failed to create main branch
    exit /b %errorlevel%
)

REM Add new remote and push branches
echo Step 7: Adding new remote and pushing branches...
git remote add origin https://github.com/humphrey71/%REPO_NAME%.git
git push -u origin dev
git push -u origin main
if %errorlevel% neq 0 (
    echo Failed to push to remote
    exit /b %errorlevel%
)

REM Set main as default branch in GitHub
echo Step 8: Setting main as default branch...
curl -X PATCH -H "Accept: application/vnd.github.v3+json" -H "Authorization: Bearer %GITHUB_TOKEN%" https://api.github.com/repos/humphrey71/%REPO_NAME% -d "{\"default_branch\":\"main\"}"
if %errorlevel% neq 0 (
    echo Failed to set default branch
    exit /b %errorlevel%
)

echo Project initialization completed successfully!
echo New repository: https://github.com/humphrey71/%REPO_NAME%.git

REM Display remote configuration
echo.
echo Remote repository configuration:
git remote -v

pause 