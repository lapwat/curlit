# curlit

An assitant that interacts with your services.

The goal is to translate human requests into cURL requests.

# How to use?

- Fill the environment variables of the services you will be using in `.env.example`.
- Open a new terminal and source that env file.
- Paste `prompt.txt` into your assistant.
- Ask a question to your assistant.
- Copy the response of your assistant in the terminal.
- Read the command (optional)
- Press Enter

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
