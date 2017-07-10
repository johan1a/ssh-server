import asyncio, asyncssh, crypt, sys, os

ssh_dir = os.environ.get('HOME') + "/.ssh"

def handle_client(process):
    process.stdout.write('Welcome to my SSH server, %s!\n' %
                         process.channel.get_extra_info('username'))
    process.exit(0)

async def start_server():
    await asyncssh.listen('', 8022, server_host_keys=[ssh_dir + '/heroku_ssh_rsa'],
                          authorized_client_keys=ssh_dir + '/ssh_user_ca',
                          process_factory=handle_client)

loop = asyncio.get_event_loop()

try:
    loop.run_until_complete(start_server())
except (OSError, asyncssh.Error) as exc:
    sys.exit('Error starting server: ' + str(exc))

loop.run_forever()
