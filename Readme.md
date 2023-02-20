# Docker base commands
#### Run docker with cluster cassandra and nodes: ``````

# SSH
This will remove the old key for the host from your known_hosts file.
When you connect to the host again, your SSH client will prompt you to accept the new key and add it to your known_hosts file.

```ssh-keygen -R "[127.0.0.1]:2222"```

got into cassandra node1 via ssh: ```ssh root@127.0.0.1 -p 2222```


```ssh-keygen -R "[127.0.0.1]:2223"```

go into cassandra node2 via ssh: ```ssh root@127.0.0.1 -p 2223```

Run command for getting info about cassandra: ```nodetool status```

# Cassandra database

127.0.0.1:9043 -> node1
127.0.0.1:9044 -> node2

