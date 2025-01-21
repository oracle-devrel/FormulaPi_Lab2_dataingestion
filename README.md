# FormulaPi_Lab2_dataingestion

[![License: UPL](https://img.shields.io/badge/license-UPL-green)](https://img.shields.io/badge/license-UPL-green) [![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=oracle-devrel_FormulaPi_Lab2_dataingestion)](https://sonarcloud.io/dashboard?id=oracle-devrel_FormulaPi_Lab2_dataingestion)

## Introduction
This is the repo that consist data ingestion code for to stream in game data to Oracle Autonomous Database

## Getting Started
1. Git Clone:
1. Download db wallet and place it in the folder
1. Run:  
      ```
      $F1SIM_HOME/bin/install_di.sh
      ```
2. Specify Python version to `3.9`
3. Create RabbitMQ login and password (We will need them later)
4. Copy  ***f1store.yaml.template *** - 
      ```
      cp f1store.yaml.template f1store.yaml
      ```
5. Configure ***f1store.yaml*** with text editor like vim or nano 
      ```
      vim f1store.yaml
      ```
6. Add following to your .yaml config file:
7.  ***gamehost*** - string
8.  ***devicename*** - string
9.  ***version*** - integer game packet configuration
10. Add RabbitMQ details from step 3 ***rmqusername***, ***rmqpassword***
11. ***dbusername*** - from your stack/db  
12. ***dbpassword*** - from your stack/db  
13. ***dbwalletpassword*** - from your stack/db  
14. ***dburl*** in Cloud Shell run  
        ```
        cat <Wallet dir>/tnsnames.ora
        ```
15. To start services run:  
        ```
        ./bin/start.sh
        ```
16. Optional, add test data:  
        ```bash
        <copy>cd test/data && tar xzvf hol-data.tar.gz && cd ../.. && . f1env.sh && python3.9 test/main.py localhost test/data/miami</copy>
        ```

### Prerequisites
* An Oracle Cloud account
* All previous labs successfully completed
* (Optional) Edge device like Raspberry Pi

## Notes/Issues

## URLs
For latest packet definition please visit [here](https://racinggames.gg/f1/f1-22-update-117-patch-notes/)

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2024 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE.txt) for more details.

ORACLE AND ITS AFFILIATES DO NOT PROVIDE ANY WARRANTY WHATSOEVER, EXPRESS OR IMPLIED, FOR ANY SOFTWARE, MATERIAL OR CONTENT OF ANY KIND CONTAINED OR PRODUCED WITHIN THIS REPOSITORY, AND IN PARTICULAR SPECIFICALLY DISCLAIM ANY AND ALL IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE.  FURTHERMORE, ORACLE AND ITS AFFILIATES DO NOT REPRESENT THAT ANY CUSTOMARY SECURITY REVIEW HAS BEEN PERFORMED WITH RESPECT TO ANY SOFTWARE, MATERIAL OR CONTENT CONTAINED OR PRODUCED WITHIN THIS REPOSITORY. IN ADDITION, AND WITHOUT LIMITING THE FOREGOING, THIRD PARTIES MAY HAVE POSTED SOFTWARE, MATERIAL OR CONTENT TO THIS REPOSITORY WITHOUT ANY REVIEW. USE AT YOUR OWN RISK. 