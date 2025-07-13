# 🎮 Minecraft Server in Docker

Spin up your own Minecraft server in minutes with Docker! Perfect for that spontaneous 2-week Minecraft phase with your friends. No hassle, just fun.

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone git@github.com:aFlamee/easy-minecraft-server.git
cd easy-minecraft-server
```

### 2. Set RCON Password

Create a `.env` file:

```env
RCON_PASSWORD=<your-secure-password>
```

> 🔒 Use a strong password. [Generate one here](https://diceware.rempe.us/#eff)

### 3. Launch the Server

```bash
docker compose up -d
```

Boom. Your Minecraft server is up on port **999**.

---

## 📁 What’s Inside

```
minecraftserver1/
├── docker-compose.yml       # Docker config
├── server.properties        # Minecraft settings
├── whitelist.sh             # Whitelist helper script
├── .env                     # RCON password (not versioned)
├── world/                   # Minecraft world folder
└── README.md                # You're reading it
```

---

## 🐳 Docker Setup

* **Minecraft Version:** 1.21.5 (Java 21)
* **Memory:** 15GB RAM
* **Ports:**

  * `999:25565` (Game, you can start multiple servers with different ports)
  * `25575:25575` (RCON)
* **Restarts on reboot**

### Server Defaults

* Game Mode: Survival
* Difficulty: Easy
* Max Players: 20
* PvP: On
* Whitelist: On (Security!)

---

## 🛠️ RCON - Remote Control

Use RCON to run commands from outside the game:

* Ban/kick players
* Change settings
* Reload whitelist

Set the password in `.env` and you’re good.

---

## 👥 Player Whitelist

Only players on the whitelist can join.

### Use the Script:

```bash
./whitelist.sh add MC_PlayerName
./whitelist.sh remove MC_PlayerName
./whitelist.sh list
./whitelist.sh reload
```

> ✅ Make sure to add yourself too!

---

## 🔐 Online-Mode Explained

### `online-mode=true` (Default)

* ✅ Only real accounts allowed
* ✅ Skins work
* 🔒 Secure
* ❌ Cracked clients blocked

### `online-mode=false`

* ✅ Cracked clients can join
* ❌ No skins
* ⚠️ Less secure (name spoofing possible)

Change it in `server.properties`:

```properties
online-mode=false
```

Restart the server afterwards:

```bash
docker compose restart
```

---

## 🗺️ World Management

### Starting Fresh

A new world is created automatically in `world/`.

### Use Your Own World

```bash
docker compose down
rm -rf world/
cp -r your-old-world/ world/
docker compose up -d
```

### Backup World

```bash
docker compose down
cp -r world/ backup-$(date +%Y%m%d)/
docker compose up -d
```

---

## ⚙️ Common Commands

* Check status: `docker compose ps`
* View logs: `docker compose logs -f mc`
* Stop server: `docker compose down`
* Restart server: `docker compose restart`
* Shell access: `docker compose exec mc bash`

---

## 🧯 Troubleshooting

### Server won’t start?

* Check logs: `docker compose logs mc`
* `.env` file missing?
* Ports in use?

### Players can’t join?

* Whitelist okay? `./whitelist.sh list`
* Added friends? `./whitelist.sh add PlayerName`
* Firewall open for port 999?

### Lag or Performance?

* Increase `MEMORY` in `docker-compose.yml`
* Lower `view-distance` in `server.properties`

---

*Built with ❤️ for everyone* 🙌 Enjoy!

