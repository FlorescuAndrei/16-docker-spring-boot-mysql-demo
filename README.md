# 16-docker-spring-boot-mysql-demo
Docker learning project.   
Take a previous app,  [14-thymeleaf-demo](https://github.com/FlorescuAndrei/14-thymeleaf-demo.git),  build a docker image.    
Upload the image to docker hub.  
Use a docker compose .yaml file that:  
  - pull the image in a local container,
  - pull a mysql image in a local container,
  - create a network and run the containers.  
After that, app is running and can be acces on http://localhost:8080/  


Steps:  
 1. Create app image  
       - in application.properties modify spring.datasource.url. Replace **localhost:3306** with **mysqlc1**, name of  mysql container.
    - delete all target file and rebuild app (.jar file) before creating docker image: 
    - add Dockerfile to source root of the app and in the console go to that root and run build command:   
        - docker build -t 16-customer-demo-app:0.1 .
        
  2. Push image to docker hub
     - login : 
       - docker login
     - create a new repo on docker hub: 
       - florescua/16-customer-demo-app
     - tag the image : 
       - tag 16-customer-demo-app:0.1 florescua/16-customer-demo-app:0.1
     - push the image: 
       - docker push florescua/16-customer-demo-app:0.1  
     
 3. Pull back the image from docker hub and run the app   
     - docker-compose -f 16customer-demo-app.yaml up 
     - docker compose use .yaml file and will:
       - pull app image and create a container for it
       - pull database image set environmetn and create another container
       - **set the run order** of container with depends-on and helthcheck
       - crate a network and run the containers.  
    
 4. View and edit customer list on http://localhost:8080/. 
     
     
  Alternativ setps or other posible steps: 
1. modify database original mysql image to match app specification:  add new user and password, add database schema:
    - pull original mysql image, run in container with changes, commit new image.(creating table with data will not be saved since there are no volume set)
      - docker run --name mysqldb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=web_customer_tracker -e MYSQL_USER=student -e MYSQL_PASSWORD=student -d mysql
    - create new image from container:
      - docker commit mysqldb  florescua/16-mysql-demo:0.1 
    - create a new repository:
      - florescua/16-mysql-demo
    - push new image to docker hub: 
      - docker push florescua/16-mysql-demo:0.1
      
2. create a network to run the app, no docker compose and .yaml file:  
  - docker network create net1
  - docker run --name mysqlc1 -p 3306:3306  -d  florescua/16-mysql-demo:0.1
  - docker network connect net1 mysqlc1
  - docker run -d -p 8080:8080 --name 16-customer-demo-app --network net1 florescua/16-customer-demo-app:0.1
  - docker network inspect net1
  - docker network ls
  - docker inspect 16-customer-demo-app
 

Notes  
Error building the .jar file:
  - After modify application.properti and change localhost to mysqlc1, the app will not run on local environment.
Will generate build error and no .jar file will be created. To build it, delete all target file and rebuild the app 
Eclipse project –run as- maven build – goals = package; **check skip test**  
  
[BACK TO START PAGE](https://github.com/FlorescuAndrei/Start.git)
