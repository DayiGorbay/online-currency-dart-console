# 💰 Currency API CLI

A command-line Dart application that fetches real-time currency data from an external API and displays it in a formatted table inside the terminal.

---

## 🚀 Features

- 📡 Fetch real-time currency data from API  
- 🔐 Secure API key management using `.env`  
- 📊 Clean CLI table output using `cli_table`  
- 🎨 Colored terminal output (positive/negative changes)  
- 🌐 Internet connection error handling  
- 🏗 Compiled as standalone `.exe`  

---

## 🛠 Technologies Used

- Dart  
- `http` package  
- `intl`
- `dotenv`  
- `cli_table`  
- ANSI escape codes (for color & console control)  

---

## 📦 Installation

### 1️⃣ Clone the repository

```bash
git clone https://github.com/your-username/currency_api.git
cd currency_api
```

### 2️⃣ Install dependencies

```bash
dart pub get
```

### 3️⃣ Create .env file

Create a file named `.env` inside project root and add:

```bash
API_URL=YOUR_API_URL
API_KEY=YOUR_API_KEY
```

⚠ Make sure .env is included in .gitignore

## ▶ Running the project

### 🏗 Build executable

```bash
dart compile exe bin/currency_api.dart
```

After build in `bin/currency_api.exe` run `currency_api.exe`

## 🖥 Console & Encoding Notes (Windows)

### UTF-8 Support

If Persian text does not display correctly in CMD:
```bash
chcp 65001
```

## Use:

- Windows Terminal (recommended)
- PowerShell
- Font: `Consolas` or `Cascadia Mono`

### RTL Limitation

Windows console does NOT properly support Right-To-Left rendering.
Persian text may appear reversed.
This is a console limitation, not a Dart issue.

## 🔑 API Setup & Data Structure

You can obtain your API key by visiting `https://brsapi.ir/` after registering on the website, generate your personal API key and add it to your `.env` file.


This project is fully structured based on the JSON response format provided by the BRSAPI.

The application parses the response using:

- `Map<String, dynamic>` for the main JSON object  
- Nested `List` inside the map for currency data collections  

The data model and logic are designed specifically according to the API's JSON structure to ensure clean parsing, scalability, and maintainability.