# Use Ubuntu base image
FROM ubuntu:latest

# Install SSH and Git
RUN apt-get update && \
    apt-get install -y openssh-server git curl

# Create SSH directory and set root password
RUN mkdir /var/run/sshd && echo 'root:rootpassword' | chpasswd

# Permit root login and fix PAM
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
