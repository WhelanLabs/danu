# Danu AI

## About
Danu AI is a Windows-based search engine with embedded AI capabilities. It is designed to serve organizations with private, 
non-Internet-accessible data, providing both search results and retrieval-augmented generation (RAG) of AI responses.

### Why Danu AI?  
Organizations often handle sensitive or proprietary data that cannot be shared externally or indexed by public search engines. 
Danu AI enables these organizations to:  
- **Securely access private data:** Ensure critical information stays within the organization.  
- **Enhance productivity:** Provide quick, accurate search results tailored to the organization's unique datasets.  
- **Leverage AI for insights:** Use RAG to generate insightful and contextually relevant responses, boosting decision-making and efficiency.  
- **Maintain compliance:** Adhere to privacy regulations by keeping data localized and under strict control.

⚠ **Note:** Danu AI is in its alpha stage and not yet ready for end-user deployment. It is publicly available to facilitate collaboration among contributors.

---

## Build, Install, and Run

### Build Environment Prerequisites
Ensure the following tools are installed and added to your system's PATH before building Danu AI:
- **Gradle**
- **Java 1.8+**
- **NSIS**: [Download NSIS 3.10](https://sourceforge.net/projects/nsis/files/NSIS%203/3.10/nsis-3.10-setup.exe/download)

### Build Steps
1. Navigate to the project’s root directory.
2. Run the following command:
   ```DOS
   build.bat
   ```

> **Note**  
> Danu also supports an advanced mode of being built using a Hyper-V VM which requires Hyper-V be installed
> on the host machine. To build using Hyper-V, open a powershell window, and run "vm_based_build.bat" instead of "build.bat".
> The Hyper-V based build requires that `Win11_24H2_English_x64.iso' be located in the download directory. The ISO image can
> be manually downloaded from https://www.microsoft.com/en-us/software-download/windows11.

#### Build Notes
- The download step may occasionally fail to fetch Apache dependencies, possibly due to Apache CDN issues. 
As a workaround, manually download the required dependencies and place them in the designated directory. 
Refer to `build.gradle` for a list of sources.

- The build output will be located at:
  ```DOS
  out\DanuAI_Installer.exe
  ```
  This is an NSIS-based installer.

---

### Installation Environment Prerequisites

Ensure the following tools are installed and added to your system's PATH before building Danu AI:
- **Java 1.8+**

---

### Installation Steps
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
   ```DOS
   [Danu]\Uninstall.exe
   ```

2. **Best Practices:**
   - Ensure Danu is shut down before uninstalling.
   - Close all Danu-related directories and files in other applications.

3. **Troubleshooting:**
   - If any files are locked, a system reboot and manual file deletion may be required to completely remove Danu AI.

---

## License
This project is licensed under the [GNU Affero General Public License v3.0](https://www.gnu.org/licenses/agpl-3.0.html).
