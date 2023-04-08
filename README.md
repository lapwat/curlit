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

Create a folder named movies

**Response**

```
curl -X MKCOL -u "$NEXTCLOUD_USERNAME:$NEXTCLOUD_PASSWORD" "$NEXTCLOUD_URL/remote.php/dav/files/$NEXTCLOUD_USERNAME/movies"
```

A new folder named "movies" was created on the Nextcloud instance.

**Prompt**

Create a CNAME entry on Cloudflare. a.mydomain.fr should point to loadbalancer.mydomain.fr

**Response**

```
curl -X POST "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/dns_records" \
     -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"CNAME","name":"a.mydomain.fr","content":"loadbalancer.mydomain.fr","ttl":120,"proxied":false}'
```

A CNAME DNS entry was created, pointing a.mydomain.fr to loadbalancer.mydomain.fr.
