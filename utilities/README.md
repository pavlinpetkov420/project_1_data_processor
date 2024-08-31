# Utilities

This directory will contain different utilities that are going to ease the work of different components in this project.

1. `pg-service-utility.sh` - Script that have the ability to start, stop and restart postgresql service on-demand. It is written to work with Windows, Linux and Max OS.
    - Running the Script:
        - Make the Script Executable:
            ```
                chmod +x pg-service-utility.sh
            ```               
        - Run the Script:
            - To start PostgreSQL:  
                `sh ./pg-service-utilityl.sh`  
            - To restart PostgreSQL:  
                `sh ./pg-service-utility.sh restart`
            - To stop PostgreSQL:  
                `sh ./pg-service-utility.sh stop`
    
    **Note: Script was generate with help of AI. So far the Windows OS related methods are working.**  
