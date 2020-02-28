
export const checkNotifications = () => {
  const notification = document.querySelector(".notification");
  document.addEventListener("DOMContentLoaded", () => {
    setInterval(notification, 3000);
  });
};

