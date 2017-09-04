import paramiko

class SSHelper(object):
	
	def __init__(self, hostname, username, password):
		super(SSHelper, self).__init__()
		self.hostname = hostname
		self.username = username
		self.password = password
		

	def run(self, command):
		""" Run a command with regular user permissions. """
		ssh = paramiko.SSHClient()
		ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
		ssh.connect(self.hostname, username=self.username, password=self.password)    
		transport = ssh.get_transport()
		session = transport.open_session()
		session.set_combine_stderr(True)
		session.get_pty()
		session.exec_command(command)
		stdout = session.makefile('r', -1)
		for line in iter(stdout.readline,""): 
			yield line
		ssh.close()	

	def sudo(self, command):
		""" Run a command with super user permissions. """
		ssh = paramiko.SSHClient()
		ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
		ssh.connect(self.hostname, username=self.username, password=self.password)    
		transport = ssh.get_transport()
		session = transport.open_session()
		session.set_combine_stderr(True)
		session.get_pty()
		session.exec_command("sudo " + command)
		stdin = session.makefile('w', -1)
		stdout = session.makefile('r', -1)
		stdin.write(self.password +'\n')
		stdin.flush()
		for line in iter(stdout.readline,""): 
			if self.password in line or "[sudo] password for" in line:
				pass
			else:
				yield line
		ssh.close()

	def put(self, source, destination):
		""" Mimmics the SFTP "put" command. Upload file to server. """
		t = paramiko.Transport((self.hostname, 22)) 
		t.connect(username=self.username, password=self.password)
		sftp = paramiko.SFTPClient.from_transport(t)
		sftp.put(source,destination)
		sftp.close()
		t.close()

	def get(self, source, destination):
		""" Mimmics the SFTP "get" command. Download file from server. """
		t = paramiko.Transport((self.hostname, 22)) 
		t.connect(username=self.username, password=self.password)
		sftp = paramiko.SFTPClient.from_transport(t)
		sftp.get(source,destination)
		sftp.close()
		t.close()