# PostgreSQL Database

So I would like to install PostgreSQL as one of the sources that will be used.(it may be called/emulate an OLTP database).  

## PostgreSQL:  
    Type `PostgreSQL` in your web search and go to the official site. (At the time of writing it is `.org`)


**[2024-Aug-11]**  
Lets Begin:    
PostgreSQL v16.4
At the time of writing the latest stable version is v16.4.  
So we start this project using that version. 

Steps:  
1.  Download PostgreSQL installer for your OS  
    a.  In my case it is a Windows installer
2. Installation  (Steps a, b and c are optional)  
    a. Change the installation target path/location  
    b. Change the data target path/location  
    c. Change the choice of installed component  
    d. Type you superuser password (Save it somewhere, password manager is prefferable choioce)
    e. Let the default 5432 port or change it if you fell you have to  
    f. Wait the installation to complete and we are done for now.
<details>  
    <summary>3. [Optional] Stop PG auto start when you turn on your computer</summary>  
    a. **On Windows**
    PostgreSQL is typically installed as a service on Windows, which means it starts automatically with Windows by default. To disable this:  

    i. **Open the Services Manager:**  
        - Press `Win + R`, type `services.msc`, and press Enter.  

    ii. **Find the PostgreSQL Service:**  
        - Look for a service named something like `PostgreSQL` or `postgresql-x64-13` (the exact name depends on the version and installation).  

    iii. **Change the Startup Type:**  
        - Right-click the PostgreSQL service and select **Properties**.  
        - In the **Startup type** dropdown, select **Manual** or **Disabled**.  
            - **Manual**: The service will not start automatically, but you can start it manually when needed.  
            - **Disabled**: The service will not start automatically, and you'll need to re-enable it to start it manually.  

    iv. **Apply the Changes:**
        - Click **Apply** and then **OK**.  


    b. **On Linux (Systemd)**
       Most modern Linux distributions use `systemd` to manage services, including PostgreSQL. To disable the auto-start:  

        i. **Open a Terminal:**

        ii. **Disable the PostgreSQL Service:**
            - Run the following command:
            ```bash
            sudo systemctl disable postgresql
            ```
            - This will prevent PostgreSQL from starting automatically at boot.

        iii. **Stop the Currently Running Service (Optional):**
            - If PostgreSQL is currently running and you want to stop it, run:
            ```bash
            sudo systemctl stop postgresql
            ```

    c. **On macOS (Homebrew)**
    If you installed PostgreSQL using Homebrew, it might be set to start automatically via `brew services`.  

        i. **Open Terminal:**

        i. **Disable Auto-Start:**
            - Run the following command to stop PostgreSQL from starting at boot:
            ```bash
            brew services stop postgresql
            ```

        iii. **Unlink from Auto-Start:**
            - To ensure it doesn’t start on boot, you can also disable it:
            ```bash
            brew services list
            ```
            - This command lists all services managed by Homebrew. Ensure PostgreSQL is not set to start automatically.
</details>