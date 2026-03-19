clear; clc; close all;
fprintf('\n===========================================================\n')
fprintf('\nInstituto Federal de Educação, Ciência e Tecnologia do Pará')
fprintf('\n                  IFPA Câmpus Ananindeua')
fprintf('\n          Bacharelado em Ciência e Tecnologia')
fprintf('\n   Componente curricular: Análise de Variável Complexa')
fprintf('\n          Dr. Denis Costa, Professor Titular\n')
fprintf('\n===========================================================\n\n')
% Limite de uma Função com Variáveis Complexas.
% Script para Cálculo de Limite Complexo: Simbólico e Numérico
% Em OCTAVE deve-se carregar o package symbolic: pkg load symbolic
%% Análise Simbólica (Cálculo Exato)
% Fatoração para "levantar" a indeterminação 0/0
syms z complex
f_sym = (z^2 + 1) / (z - 1i); % Função Complexa
z0 = 1i; % Tendência

% Tentativa de limite direto (possíveis erros da análise simbólica)
try
    L_exato = limit(f_sym, z, z0);
catch
    % Caso o comando 'limit' falhe, simplifica-se manualmente
    f_simples = simplify(f_sym);
    L_exato = subs(f_simples, z, z0);
end

fprintf('>>> Resultado Simbólico <<<\n');
fprintf('A função simplificada é: %s\n', char(simplify(f_sym)));
fprintf('O valor exato do limite quando z -> i é: %s\n\n', char(L_exato));

%% Análise Numérica (Verificação por Caminhos)
% Definição da função anônima para cálculos rápidos
f_num = @(z) (z.^2 + 1) ./ (z - 1i);

% Vetor de aproximação (de 0.1 até 10^-8)
h = logspace(-1, -8, 50);

% Caminhos: Direita (Re+), Esquerda (Re-), Cima (Im+), Baixo (Im-)
caminho_re_pos = z0 + h;
caminho_im_pos = z0 + 1i*h;

% Cálculo dos valores da função ao longo dos caminhos
val_re = f_num(caminho_re_pos);
val_im = f_num(caminho_im_pos);

fprintf('>>> Verificação Numérica (Aproximação) <<<\n');
fprintf('Aproximando pelo Eixo Real:      %f + %fi\n', real(val_re(end)), imag(val_re(end)));
fprintf('Aproximando pelo Eixo Imaginário: %f + %fi\n\n', real(val_im(end)), imag(val_im(end)));

%% Representação Gráfica
figure('Color', 'k');
plot(1:length(h), real(val_re), '-o', 'LineWidth', 1.5); hold on;
plot(1:length(h), imag(val_re), '-s', 'LineWidth', 1.5);
grid on;
legend('Parte Real', 'Parte Imaginária');
title('Convergência do Limite Complexo (z \rightarrow i)');
xlabel('Passo da Aproximação (n)');
ylabel('Valor de f(z)');
fprintf('\n  === Fim da simulação ===    \n')