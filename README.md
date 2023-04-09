# curlit

An assitant that interacts with your services.

The goal is to translate human requests into cURL requests.

# How to use?

- Create a your custom `.env` similar to `.env.example`.
- Open a new terminal and source that env file.
- Paste `prompt.txt` into your assistant (update env var references if needed) 
- Ask a question to your assistant.
- Copy the response of your assistant in the terminal.
- Read the command (optional)
- Press Enter

# Automatic command executions

It uses a fork of `kharvd/gpt-cli` --> `lapwat/gpt-cli`. It detects code blocks in your assistant responses and ask you if you'd like to execute them.

At least `OPENAI_API_KEY` in env file is mandatory here.

```sh
# build docker container
docker build -t curlit .`

# run docker container with your custom env
docker run -it --env-file=.env curlit
```

# Init the prompt

```
Hi! I'm here to help. Type q or Ctrl-D to exit, c or Ctrl-C to clear the
conversation, r or Ctrl-R to re-generate the last response. To enter multi-line
mode, enter a backslash \ followed by a new line. Exit the multi-line mode by
pressing ESC and then Enter (Meta+Enter).

> # Paste prompt.txt here

Ready!

> create a github repo named curlit

 curl -H "Authorization: token $GITHUB_ACCESS_TOKEN" \
      --request POST \
      --data '{"name":"curlit"}' \
      https://api.github.com/user/repos


Code block:
curl -H "Authorization: token $GITHUB_ACCESS_TOKEN" \
     --request POST \
     --data '{"name":"curlit"}' \
     https://api.github.com/user/repos

Do you want to run this code block? (y/n) y
```

# Services

- GitHub
- Nextcloud
- Cloudflare

# Examples

**Prompt**

Create a private repo named curlit-demo

**Response**

```
curl -X POST -H "Authorization: token $GITHUB_ACCESS_TOKEN" -d '{"name": "curlit-demo"}' https://api.github.com/user/repos
```

**Prompt**

Open an issue asking to add a license to the repo with a kind description

**Response**

```
curl -X POST -H "Authorization: token $GITHUB_ACCESS_TOKEN" -d '{"title":"Add license to repository", "body":"Hello, could you please add a license to this repository? It would be greatly appreciated. Thank you!"}' "https://api.github.com/repos/$GITHUB_USERNAME/curlit-demo/issues"
```

**Prompt**

Create a folder named movies on my nextcloud instance

**Response**

```
curl -X MKCOL -u "$NEXTCLOUD_USERNAME:$NEXTCLOUD_PASSWORD" "$NEXTCLOUD_URL/remote.php/dav/files/$NEXTCLOUD_USERNAME/movies"
```

**Prompt**

Create a CNAME entry on Cloudflare. a.mydomain.fr should point to loadbalancer.mydomain.fr

**Response**

```
curl -X POST "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records" \
     -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"CNAME","name":"a.mydomain.fr","content":"loadbalancer.mydomain.fr","ttl":120,"proxied":false}'
```
