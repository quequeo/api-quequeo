## Steps to deploy on AWS EC2 instance 🚀

### **1. Set Up the EC2 Instance**
1. **Create an EC2 instance** in your AWS account.
2. **Generate an RSA key pair** and download the `<aws_key_file>.pem` file.
3. **Secure your key file**:
    ```bash
    chmod 400 <aws_key_file>.pem
    ```

4. **Connect to your EC2 instance via SSH**:
    ```bash
    ssh -i "<aws_key_file>.pem" ec2-user@<ec2-public-ip>
    ```

### **2. Install Necessary Software**
1. **Update the instance and install Docker**:
    ```bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y docker.io
    ```

2. **Install Docker Compose**:
    ```bash
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    ```

3. **Verify installations**:
    ```bash
    docker --version
    docker-compose --version
    ```

### **3. Transfer Files to the Instance**
1. **Locate your app's folder** on your local machine:
    ```bash
    pwd
    ```

2. **Navigate to the app directory**.
    (example path)
    ```bash
    cd /Users/jaime/Desktop/Apps/wellio-fit/api-wellio-fit
    ```

3. **(Optional) Prepare the app**:
    Clean cache (if applicable):
      ```bash
      rm -rf tmp/cache
      ```

4. **Transfer files using `rsync`**:
    ```bash
    rsync -avz -e "ssh -i <aws_key_file>.pem" /path/to/local/app ec2-user@<ec2-public-ip>:/home/ec2-user/app
    ```
    Example:
    ```bash
    rsync -avz -e "ssh -i Wellio-API-AWS-RSA-Key.pem" /Users/jaime/Desktop/Apps/wellio-fit/api-wellio-fit ubuntu@ec2-3-82-54-64.compute-1.amazonaws.com:/home/ubuntu/app
    ```

### **4. Build and Run the Application**

1. **Navigate to the app folder on the EC2 instance**:
(example path)
    ```bash
    cd app/api-wellio-fit
    ```

2. **Build the Docker containers**:
    ```bash
    sudo docker-compose build
    ```

3. **Run the containers**:
    ```bash
    sudo docker-compose up -d
    ```

4. **Verify the containers are running**:
    ```bash
    sudo docker ps
    ```

5. **Access your application**:
   * Open your browser and navigate to `http://<ec2-public-ip>:<port>` (replace `<port>` with the exposed port defined in your `docker-compose.yml`).

### **5. Common Errors and Fixes**

1. **Permission denied while trying to connect to the Docker daemon socket**:
   * **Cause**: The user does not have access to the Docker socket.
   * **Solution**: Add the user to the Docker group:
      ```bash
      sudo usermod -aG docker $USER
      ```
      *Note*: Log out and back in for changes to take effect.

2. **Containers failing to start**:
   * **Cause**: Missing environment variables or configuration files.
   * **Solution**: Verify your `.env` file or configurations in the `docker-compose.yml`.

3. **Port is already in use**:
   * **Solution**: Check for processes using the port and stop them:
      ```bash
      sudo lsof -i:<port>
      sudo kill <pid>
      ```

### **Tips**
* Always verify the file paths and IP addresses when transferring files or connecting to the instance.
* Ensure your security group settings allow SSH and the necessary ports for your app (e.g., port 80 for HTTP, port 443 for HTTPS).
