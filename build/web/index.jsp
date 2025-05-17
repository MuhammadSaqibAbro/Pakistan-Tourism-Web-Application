<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Pakistan Tourism</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fa;
            color: #333;
            overflow-x: hidden;
        }

        /* Header Styles */
        .header {
            background-color: #1e2a33; /* Darker background for more contrast */
            color: #ffffff;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 50px 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            background-image: linear-gradient(to bottom right, #1e2a33, #304156); /* Gradient effect */
        }

        .header h1 {
            font-size: 50px;
            margin-bottom: 15px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #f7d06a; /* A warm golden color */
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.4);
            animation: fadeIn 2s ease-in-out;
        }

        .header p {
            font-size: 20px;
            margin-bottom: 40px;
            color: #e6f1f7; /* Light blue for text */
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            line-height: 1.5;
        }

        /* Header Navbar Styles */
        .navbar {
            background-color: #102030;
            padding: 10px 20px;
            text-align: center;
            position: absolute;
            top: 0;
            width: 150%;
            z-index: 1000;
        }

        .navbar a {
            color: #f7d06a;
            text-decoration: none;
            font-size: 18px;
            padding: 12px 20px;
            margin: 0 15px;
            transition: background-color 0.3s;
        }

        .navbar a:hover {
            background-color: #f1b600;
            border-radius: 5px;
        }

        /* Buttons Container */
        .buttons-container {
            display: flex;
            gap: 30px;
            justify-content: center;
            align-items: center;
            animation: fadeIn 3s ease-in-out;
        }

        .button {
            background-color: #f7d06a; /* Golden color for buttons */
            color: #1e2a33;
            padding: 15px 30px;
            border-radius: 50px;
            font-size: 18px;
            text-decoration: none;
            transition: all 0.3s ease;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: inline-block;
            font-weight: 600;
        }

        .button:hover {
            background-color: #f1b600; /* Darker golden color */
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .button:active {
            transform: translateY(0);
        }

        /* Footer Styles */
        .footer {
            background-color: #1e2a33;
            color: #ffffff;
            text-align: center;
            padding: 20px 0;
            position: fixed;
            width: 100%;
            bottom: 0;
            box-shadow: 0 -4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Hiding any buttons in footer */
        .footer .button {
            display: none;
        }

        /* Keyframe Animations */
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(-20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Media Queries */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 36px;
            }

            .header p {
                font-size: 16px;
            }

            .buttons-container {
                flex-direction: column;
                gap: 20px;
            }

            .button {
                padding: 12px 25px;
                font-size: 16px;
            }

            .navbar a {
                font-size: 16px;
                padding: 10px 15px;
            }
        }

        /* Scroll to Top Button */
        .scroll-top-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #204060;
            color: white;
            border-radius: 50%;
            padding: 10px 15px;
            font-size: 24px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            display: none;
            z-index: 10;
        }

        .scroll-top-btn:hover {
            background-color: #102030;
        }
    </style>
</head>
<body>

    <!-- Header Navbar Section -->
    <div class="navbar">
        <br><br><br><br>
    </div>

    <!-- Main Header Section -->
    <div class="header">
        <h1>Welcome to Pakistan Tourism</h1>
        <p>Discover the wonders of the Pakistan – rich history, cultural treasures, and adventure await!</p>

        <!-- Navigation Buttons -->
        <div class="buttons-container">
            <a href="admin_login.jsp" class="button">Admin Section</a>
            <a href="user_login.jsp" class="button">User Section</a>
        </div>
    </div>

    <!-- Footer Section -->
    <div class="footer">
        <p>&copy; 2025 Pakistan Tourism. All rights reserved.</p>
    </div>

    <!-- Scroll to Top Button -->
    <div class="scroll-top-btn" id="scrollTopBtn" onclick="scrollToTop()">↑</div>

    <script>
        // Scroll to top functionality
        window.onscroll = function() {
            toggleScrollTopButton();
        };

        function toggleScrollTopButton() {
            if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
                document.getElementById("scrollTopBtn").style.display = "block";
            } else {
                document.getElementById("scrollTopBtn").style.display = "none";
            }
        }

        function scrollToTop() {
            document.body.scrollTop = 0;
            document.documentElement.scrollTop = 0;
        }
    </script>

</body>
</html>
