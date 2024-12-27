# Danu AI

## About
Danu AI is a Windows-based search engine with embedded AI capabilities. It is designed to serve organizations with private, non-Internet-accessible data, providing both search results and retrieval-augmented generation (RAG) of AI responses.

### Why Danu AI?  
Organizations often handle sensitive or proprietary data that cannot be shared externally or indexed by public search engines. Danu AI enables these organizations to:  
- **Securely access private data:** Ensure critical information stays within the organization.  
- **Enhance productivity:** Provide quick, accurate search results tailored to the organization's unique datasets.  
- **Leverage AI for insights:** Use RAG to generate insightful and contextually relevant responses, boosting decision-making and efficiency.  
- **Maintain compliance:** Adhere to privacy regulations by keeping data localized and under strict control.

⚠ **Note:** Danu AI is in its alpha stage and not yet ready for end-user deployment. It is publicly available to facilitate collaboration among contributors.

---

## Build, Install, and Run

### Build Environment Prerequisites
Ensure the following tools are installed and added to your system's PATH before building Danu AI:
- **Java v1.8+**
- **Gradle**
- **NSIS**: [Download NSIS 3.10](https://sourceforge.net/projects/nsis/files/NSIS%203/3.10/nsis-3.10-setup.exe/download)

### Build Steps
1. Navigate to the project’s root directory.
2. Run the following command:
   ```bash
   build.bat
   ```

#### Build Notes
- The download step may occasionally fail to fetch Apache dependencies, possibly due to Apache CDN issues. As a workaround, manually download the required dependencies and place them in the designated directory. Refer to `build.gradle` for a list of sources.

- The build output will be located at:
  ```
  out\DanuAI_Installer.exe
  ```
  This is an NSIS-based installer.

---

### Installation
To install Danu AI:
1. Download `DanuAI_Installer.exe` to the target machine.
2. Execute the installer.

---

### Runtime Environment Prerequisites
The following tool must be installed and added to the system's PATH before running Danu AI:
- **Cygwin**

🚨 *Future Enhancement:* The installer will include a check for Cygwin and install it if missing.

---

### Running Danu AI
Follow these steps to run Danu AI:

1. Start the service:
   ```DOS
   cd [Danu]
   startup.bat
   ```

2. Crawl target URLs and load them into the Danu database:
   ```DOS
   crawl.bat
   ```

3. To stop the service:
   ```DOS
   shutdown.bat
   ```

---

### Uninstallation
To uninstall Danu AI:
1. Run the uninstaller:
   ```bash
   [Danu]\Uninstall.exe
   ```

2. **Best Practices:**
   - Ensure Danu is shut down before uninstalling.
   - Close all Danu-related directories and files in other applications.

3. **Troubleshooting:**
   - If any files are locked, a system reboot and manual file deletion may be required to completely remove Danu AI.

---

## Developer Notes

### Testing GitHub Actions Workflow Locally with `act`

`act` is an open-source tool that allows you to simulate and run GitHub Actions workflows locally on your development machine before pushing code to the repository. This ensures that your workflows are error-free and perform as expected without needing to rely on the remote GitHub Actions environment.

#### Prerequisites for Using `act`
1. **Install Docker**: Ensure Docker is installed and running on your local machine, as `act` uses Docker containers to replicate GitHub Actions runners.
2. **Install `act`**:
   - **On Windows**: 
     ```bash
     scoop install act
     ```
   - Alternatively, download the binary from the [GitHub Releases page](https://github.com/nektos/act/releases).

3. **Configure `act`**:
   - Ensure your repository contains a `.github/workflows` directory with your GitHub Actions workflow YAML files.
   - If your workflows require secrets, create a `.secrets` file with the required key-value pairs:
     ```
     MY_SECRET=some_value
     ```

#### Running Your Workflow Locally
1. **Navigate to Your Repository**:
   Open a terminal and navigate to the root directory of your project.

2. **Run the Default Workflow**:
   To test the default workflow (triggered by a `push` event):
   ```bash
   act
   ```

3. **Simulate a Specific Event**:
   You can specify the GitHub event to simulate. For example, to test a `pull_request` workflow:
   ```bash
   act pull_request
   ```

4. **Test with a Specific Runner**:
   GitHub Actions supports different runners (`ubuntu-latest`, `windows-latest`, etc.). Use the `-P` option to specify the runner. For example:
   ```bash
   act -P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest
   ```

5. **Include Secrets**:
   If your workflow requires secrets, run `act` with the `--secret-file` option:
   ```bash
   act --secret-file .secrets
   ```

#### Debugging Workflow Issues Locally
- **Inspect Logs**:
  `act` outputs logs similar to GitHub Actions. Analyze the logs to identify any errors or unexpected behavior.
- **Modify Workflow**:
  Make changes to your `.yml` files or scripts, then re-run `act` to test the updated configuration.
- **Verify Runner Compatibility**:
  Ensure the Docker image specified for the runner matches the environment expected in GitHub Actions.

#### Benefits of Local Testing with `act`
1. **Faster Feedback Loop**: No need to commit and push changes to test your workflows.
2. **Offline Development**: Test workflows even without an internet connection (except for initial `act` setup).
3. **Debugging Confidence**: Understand and fix errors before they reach GitHub, minimizing disruption to team workflows.

#### Example Command Summary
| Command                                  | Description                              |
|------------------------------------------|------------------------------------------|
| `act`                                    | Run the default workflow (push event).   |
| `act pull_request`                       | Simulate a pull request event.           |
| `act -P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest` | Use a specific runner.                  |
| `act --secret-file .secrets`             | Include secrets for the workflow.        |

#### Integration with Your Workflow
By incorporating `act` into your development process, you can ensure your CI/CD pipelines are robust and error-free, improving overall productivity and confidence when working with GitHub Actions.


### Monitoring and Troubleshooting GitHub Actions Workflow

#### Overview
The GitHub Actions workflow for this project automates the build and runtime testing of Danu AI. It is configured to execute on every push to the `main` branch and for pull requests. The workflow is divided into two main jobs:
1. **Build**: Builds the project and produces the installer executable.
2. **Test**: Installs and runs the project in a simulated runtime environment.

Both jobs are executed on Windows-based containers using Docker.

#### Monitoring the Workflow
You can monitor the progress and results of the GitHub Actions workflow by following these steps:
1. **Accessing GitHub Actions**:
   - Navigate to the repository's GitHub page.
   - Click on the **"Actions"** tab in the top menu.
2. **Selecting a Workflow**:
   - Choose the most recent workflow run from the list (e.g., triggered by a push or pull request).
   - Click on the workflow name to view its detailed status.
3. **Reviewing Job Details**:
   - The workflow is divided into jobs, typically "Build" and "Test".
   - Click on a job to expand its execution logs and see each step's output.

#### Interpreting Results
Each job may result in one of the following statuses:
1. **Success**:
   - The job completed without errors.
   - The build job will generate the `DanuAI_Installer.exe` artifact.
   - The test job will confirm that the runtime environment is properly set up and the scripts execute as expected.
2. **Failure**:
   - One or more steps encountered errors. Expand the logs for the failed step to see the error messages.
   - Common issues:
     - **Build Errors**:
       - Missing prerequisites (e.g., Java, Gradle, NSIS).
       - Download issues for dependencies.
     - **Test Errors**:
       - Installation failures (e.g., missing runtime prerequisites like Cygwin).
       - Script execution errors.
3. **Skipped**:
   - The job did not run because of dependency issues (e.g., if the build job fails, the test job will be skipped).

#### Actions for Common Results
- **If the Build Job Fails**:
  - Check the logs for error details, particularly around dependency installation or the `build.bat` script.
  - Verify that all prerequisites are installed and correctly configured in the Dockerfile.
  - Ensure the `build.bat` script is in the root directory.

- **If the Test Job Fails**:
  - Review the logs for runtime script errors.
  - Ensure that the runtime scripts in the `runtime_scripts` folder are functional and correctly referenced in the Dockerfile.

- **For Persistent Issues**:
  - Rerun the workflow by clicking **"Re-run jobs"** in the workflow interface.
  - Test locally by replicating the Docker environment defined in the `Dockerfile`.

#### Accessing Artifacts
If the build job is successful, the installer artifact (`DanuAI_Installer.exe`) will be available for download:
1. Navigate to the completed workflow run.
2. Expand the "Artifacts" section and download the file.

#### Additional Tips
- Use the **"Annotations"** section to quickly identify errors. GitHub Actions highlights issues in logs.
- For debugging purposes, you can run the workflow locally using the [GitHub Actions Runner](https://github.com/actions/runner).

By actively monitoring and troubleshooting these workflows, you can ensure the reliability and functionality of the Danu AI project across build and runtime environments.

---

## License
This project is licensed under the [GNU Affero General Public License v3.0](https://www.gnu.org/licenses/agpl-3.0.html).
