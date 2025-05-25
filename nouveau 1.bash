<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Timer - Le live commence dans</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@900&display=swap');

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Orbitron', monospace, sans-serif;
    }

    body {
      height: 100vh;
      background: linear-gradient(135deg, #0ff 0%, #00f 100%);
      color: #00f;
      display: flex;
      justify-content: center;
      align-items: center;
      overflow: hidden;
      position: relative;
    }

    .timer-container {
      border: 5px solid #00f;
      border-radius: 30px;
      padding: 40px;
      background-color: rgba(0, 0, 50, 0.6);
      box-shadow: 0 0 30px #0ff, inset 0 0 10px #00f;
      text-align: center;
      width: 90%;
      max-width: 700px;
      z-index: 10;
    }

    h1 {
      font-size: 2rem;
      color: #0ff;
      margin-bottom: 30px;
    }

    #timer {
      font-size: 6rem;
      color: white;
      text-shadow: 0 0 15px #0ff;
    }

    .floating-objects, .particles {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      z-index: 1;
      pointer-events: none;
    }

    .floating-objects div {
      position: absolute;
      background: rgba(0, 255, 255, 0.2);
      border: 2px solid #0ff;
      border-radius: 20%;
      animation: float 8s infinite ease-in-out;
    }

    .floating-objects .obj1 {
      width: 100px;
      height: 100px;
      top: 10%;
      left: 10%;
    }
    .floating-objects .obj2 {
      width: 150px;
      height: 150px;
      top: 70%;
      left: 60%;
    }
    .floating-objects .obj3 {
      width: 80px;
      height: 80px;
      top: 50%;
      left: 80%;
    }

    .particles div {
      position: absolute;
      width: 3px;
      height: 3px;
      background: #0ff;
      opacity: 0.6;
      border-radius: 50%;
      animation: rise 8s infinite linear;
    }

    .three-objects {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      z-index: 0;
    }

    .three-objects div {
      position: absolute;
      border-radius: 50%;
      background: radial-gradient(circle at center, #0ff, #004);
      box-shadow: 0 0 60px #0ff, inset 0 0 30px #00f;
      opacity: 0.3;
      animation: spin 20s linear infinite;
    }

    .three-objects .ring1 {
      width: 300px;
      height: 300px;
      top: 20%;
      left: 50%;
      margin-left: -150px;
    }

    .three-objects .ring2 {
      width: 200px;
      height: 200px;
      bottom: 10%;
      right: 10%;
    }

    .three-objects .ring3 {
      width: 250px;
      height: 250px;
      top: 10%;
      left: 70%;
    }

    .signature {
      position: absolute;
      bottom: 20px;
      left: 20px;
      font-size: 4rem;
      font-weight: 900;
      font-family: 'Orbitron', monospace;
      color: #0ff;
      text-shadow:
        0 0 5px #0ff,
        0 0 10px #0ff,
        0 0 12px #00f;
      letter-spacing: 0.15em;
      opacity: 1;
      pointer-events: none;
      user-select: none;
    }

    @keyframes float {
      0% { transform: translateY(0px); }
      50% { transform: translateY(-20px); }
      100% { transform: translateY(0px); }
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    @keyframes rise {
      0% { transform: translateY(100vh); opacity: 0.6; }
      100% { transform: translateY(-10vh); opacity: 0; }
    }
  </style>
</head>
<body>
  <div class="three-objects">
    <div class="ring1"></div>
    <div class="ring2"></div>
    <div class="ring3"></div>
  </div>

  <div class="floating-objects">
    <div class="obj1"></div>
    <div class="obj2"></div>
    <div class="obj3"></div>
  </div>

  <div class="particles"></div>

  <div class="timer-container">
    <h1>Le live commence dans</h1>
    <div id="timer">30:00</div>
  </div>

  <div class="signature">Kyron</div>

  <script>
    let duration = 30 * 60; // 30 minutes
    let timeLeft = duration;
    let timerInterval;
    let running = false;

    const timerEl = document.getElementById("timer");
    const particlesContainer = document.querySelector(".particles");

    function updateDisplay() {
      const minutes = Math.floor(timeLeft / 60);
      const seconds = timeLeft % 60;
      timerEl.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    }

    function startTimer() {
      if (!running) {
        running = true;
        timerInterval = setInterval(() => {
          if (timeLeft > 0) {
            timeLeft--;
            updateDisplay();
          } else {
            clearInterval(timerInterval);
            running = false;
          }
        }, 1000);
      }
    }

    function stopTimer() {
      clearInterval(timerInterval);
      running = false;
    }

    function resetTimer() {
      stopTimer();
      timeLeft = duration;
      updateDisplay();
    }

    document.addEventListener("keydown", (e) => {
      if (e.code === "Space") {
        e.preventDefault();
        running ? stopTimer() : startTimer();
      }
      if (e.key.toLowerCase() === "r") {
        resetTimer();
      }
    });

    updateDisplay();

    // Générer des particules dynamiquement (200 particules)
    for (let i = 0; i < 200; i++) {
      const p = document.createElement("div");
      p.style.left = Math.random() * 100 + "%";
      p.style.top = Math.random() * 100 + "%";
      p.style.animationDuration = (4 + Math.random() * 6) + "s";
      p.style.width = (2 + Math.random() * 4) + "px";
      p.style.height = p.style.width;
      particlesContainer.appendChild(p);
    }
  </script>
</body>
</html>
