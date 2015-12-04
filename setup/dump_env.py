import os


envs = os.environ
f = open('/srv/app/.env', 'a', 0)
for key, value in envs.iteritems():
    f.write('export ' + key + '=' '\"' + value + '\"' + '\n')
f.close
