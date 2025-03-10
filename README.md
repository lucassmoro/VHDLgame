# Jogo das Sequências

O projeto final consiste na implementação de um circuito na placa de desenvolvimento DE2 fazendo uso das estruturas e conhecimentos obtidos durante o curso. O circuito vai implementar a um jogo interativo de dois jogadores, um jogador que introduz as sequencias (J1) e o jogador que deve adivinhar a continuação das sequencias em BCD mostradas no displays (J2). O comportamento do jogo está definido a seguir:

- Os jogadores começam no estado Init resetando o jogo para passar diretamente ao estado Setup. Uma vez no estado Setup os jogadores deverão escolher um dos 4 níveis de dificuldade com os Switches, SW(1..0). A letra L de Level aparecera no HEX1 e o nível do jogo no HEX0, sendo 0 o nível com menor penalização por erro na deteção das sequencias e 3 o nível com maior penalização por erro na deteção das mesmas. O numero de rodadas (16) e mostrado nos LEDRs em formato termometrico.

- Uma vez pressionado o botão de pressão enter (KEY1) o jogo passa ao estado Select, onde o jogador (J1) deve selecionar as constantes α e β da equação F = α × X + β, onde 0 ≤ X ≤ 4. O jogador pode escolher 1 ≤ α ≤ 15 e 1 ≤ α ≤ 15 com os Switches SW(7..4) e SW(3..0) para α e β respectivamente. A escolha dos parâmetros nesse estado tem de ser de forma secreta para o jogador (J2). Uma vez escolhidas as constantes α e β, o jogador J1 deve pressionar enter e voltar rapidamente colocar todos os switches a zeros. Caso durante o jogo, a contagem do tempo apresentada nos displays HEX7 e HEX6 esteja zerada (ou negativa) um sinal de status chamado end_game será ativado e o sistema vai para o estado Result. Se o numero de rodadas máximo 16 foi atingido, um sinal de status chamado end_round será ativado e o jogo vai para o estado Result.

- Uma vez pressionado o botão de pressão enter (KEY1) o jogo passa ao estado Sequence e se inicia o jogo com a primeira rodada. No estado Sequence, aparecerá em HEX7 e HEX6 o valor inicial de uma contagem regressiva em segundos para o jogador (J2). O valor inicial da contagem regressiva será de 99 segundos. São mostrados nos displays HEX1 HEX0 uma sequencia de 4 valores em BCD para o jogador (J2) mostrada a uma frequência de 1Hz. Uma vez que foi mostrada a sequencia de 4 valores será ativado um status end_sequence e o jogo passa ao estado Play.

- Uma vez no estado Play começa a contagem regressiva e o jogador (J2) tem de colocar o valor do seguinte valor da sequencia (α×4+β) em BCD usando os SW(7...0). Uma vez seleccionado o valor nos SW o jogador (J2) pressionara enter no botão KEY(1) e a sua contagem parará e passamos ao estado Check.

- No estado Check será avaliado se foi adivinhado o valor das sequencias pelo jogador (J2). Caso o jogador (J2) não adivinhe será subtraído 2, 4, 6 ou 8 segundos na contagem regressiva dependendo de se escolhemos nível de dificuldade 0, 1, 2 ou 3, respectivamente. Nesse estado será descontado uma rodada do contador de rodadas. Do estado Check passamos diretamente ao estado Select.

- No estado Result, será mostrado nos displays HEX(7..6) o tempo que sobrou para (J2) e os LEDRs piscando a uma frequência de 2HZ. Os jogadores deverão pressionar enter para passar ao estado Init e iniciar outro jogo.

- Um usuário pode a qualquer momento, parar o jogo usando o botão de pressão reset (KEY0) zerando o sistema, para assim re-iniciar de novo.

- Para o sinal de relógio o aluno pode usar CLK = CLK_500Hz para testes usando emulador online (ou usar o sinal de CLK_1Hz ao invés do divisor de frequência dado). Para testes na placa DE2 os alunos devem usar o relógio interno de 50Mhz CLK = CLOCK_50. Visando evitar problemas de temporização em função do aperto de um KEY por um ser humano durar muitos ciclos de clock, o Button Press Synchronizer (ButtonSync) será fornecido em conjunto com o projeto para ser utilizado. O ButtonSync converte apertos das KEYS em pulsos com período de um ciclo de clock.

- O projeto deverá ser implementado obrigatoriamente usando a abordagem datapath-control vista nas aulas de teoria. O modelo de datapath pode ser encontrado no Moodle da disciplina. O aluno deve projetar o datapath e juntar com o controlador.
