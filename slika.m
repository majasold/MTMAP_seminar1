k_values=[30,40,50,60,70];



figure; hold on;
plot(k_values, tocnost(1,:), 'ro-', 'LineWidth', 2, 'DisplayName', 'p=30');
plot(k_values, tocnost(2,:), 'bs-', 'LineWidth', 2, 'DisplayName', 'p=40');
plot(k_values, tocnost(3,:), 'g^-', 'LineWidth', 2, 'DisplayName', 'p=50');
plot(k_values, tocnost(4,:), 'md-', 'LineWidth', 2, 'DisplayName', 'p=60');
plot(k_values, tocnost(5,:), 'k*-', 'LineWidth', 2, 'DisplayName', 'p=70');

% Postavljanje oznaka i legende
xlabel('Broj q');
ylabel('Točnost');
title('Usporedba točnosti za parametre, k=12');
grid on;
legend('Location', 'best'); % Dodaje legendu
hold off;