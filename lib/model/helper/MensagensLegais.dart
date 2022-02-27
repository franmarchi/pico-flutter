import 'package:flutter/material.dart';

class MensagensLegais {
  MensagensLegais();

  exibirTermosdeUso(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Termos de Uso"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1. Termos"),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Ao acessar ao site e/ou aplicativo Ótica Pico, concorda em cumprir estes termos de serviço, todas as leis e regulamentos aplicáveis e concorda que é responsável pelo cumprimento de todas as leis locais aplicáveis. Se você não concordar com algum desses termos, está proibido de usar ou acessar este site e/ou aplicativo. Os materiais contidos neste site são protegidos pelas leis de direitos autorais e marcas comerciais aplicáveis."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("2. Uso de Licença"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "É concedida permissão para baixar temporariamente uma cópia dos materiais (informações ou software) no site e/ou aplicativo da Ótica Pico, apenas para visualização transitória pessoal e não comercial. Esta é a concessão de uma licença, não uma transferência de título e, sob esta licença, você não pode: "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text("• modificar ou copiar os materiais;"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                            "• usar os materiais para qualquer finalidade comercial ou para exibição pública (comercial ou não comercial); "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                            "• tentar descompilar ou fazer engenharia reversa de qualquer software contido no site da Ótica Pico; "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                            "• remover quaisquer direitos autorais ou outras notações de propriedade dos materiais;"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                            "• ou transferir os materiais para outra pessoa ou 'espelhe' os materiais em qualquer outro servidor. "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Esta licença será automaticamente rescindida se você violar alguma dessas restrições e poderá ser rescindida por Ótica Pico a qualquer momento. Ao encerrar a visualização desses materiais ou após o término desta licença, você deve apagar todos os materiais baixados em sua posse, seja em formato eletrônico ou impresso. "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("3. Isenção de responsabilidade"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Os materiais no site e/ou aplicativo da Ótica Pico são fornecidos 'como estão'. Ótica Pico não oferece garantias, expressas ou implícitas, e, por este meio, isenta e nega todas as outras garantias, incluindo, sem limitação, garantias implícitas ou condições de comercialização, adequação a um fim específico ou não violação de propriedade intelectual ou outra violação de direitos."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Além disso, a Ótica Pico não garante ou faz qualquer representação relativa à precisão, aos resultados prováveis ou à confiabilidade do uso dos materiais em seu site e/ou aplicativo ou de outra forma relacionado a esses materiais ou em sites vinculados a este site e/ou aplicativo."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("4. Limitações"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Em nenhum caso a Ótica Pico ou seus fornecedores serão responsáveis por quaisquer danos (incluindo, sem limitação, danos por perda de dados ou lucro ou devido a interrupção dos negócios) decorrentes do uso ou da incapacidade de usar os materiais em Pico, mesmo que Ótica Pico ou um representante autorizado da Ótica Pico tenha sido notificado oralmente ou por escrito da possibilidade de tais danos. Como algumas jurisdições não permitem limitações em garantias implícitas, ou limitações de responsabilidade por danos consequentes ou incidentais, essas limitações podem não se aplicar a você. "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("5. Precisão dos materiais"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Os materiais exibidos no site da Ótica Pico podem incluir erros técnicos, tipográficos ou fotográficos. Ótica Pico não garante que qualquer material em seu site seja preciso, completo ou atual. Ótica Pico pode fazer alterações nos materiais contidos em seu site e/ou aplicativo a qualquer momento, sem aviso prévio. No entanto, Ótica Pico se compromete a atualizar os materiais. "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("6. Links"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            " A Ótica Pico não analisou todos os sites vinculados ao seu site e/ou aplicativo e não é responsável pelo conteúdo de nenhum site vinculado. A inclusão de qualquer link não implica endosso por Ótica Pico. O uso de qualquer site vinculado é por conta e risco do usuário. "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("7.Modificações"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "A Ótica Pico pode revisar estes termos de serviço do site e/ou aplicativo a qualquer momento, sem aviso prévio. Ao usar este site, você concorda em ficar vinculado à versão atual desses termos de serviço. "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("Lei aplicável"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Estes termos e condições são regidos e interpretados de acordo com as leis da Ótica Pico e você se submete irrevogavelmente à jurisdição exclusiva dos tribunais naquele estado ou localidade."),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Fechar")),
            ],
          );
        });
  }

  exibirPoliticaPrivacidade(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Politica Privacidade"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "A sua privacidade é importante para nós. É política da Ótica Pico respeitar a sua privacidade em relação a qualquer informação sua que possamos coletar no site da Ótica Pico, e outros sites que possuímos e operamos."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Solicitamos informações pessoais apenas quando realmente precisamos delas para lhe fornecer um serviço. Fazemo-lo por meios justos e legais, com o seu conhecimento e consentimento. Também informamos por que estamos coletando e como será usado. Apenas retemos as informações coletadas pelo tempo necessário para fornecer o serviço solicitado. Quando armazenamos dados, protegemos dentro de meios comercialmente aceitáveis para evitar perdas e roubos, bem como acesso, divulgação, cópia, uso ou modificação não autorizados."),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Text(
                              "Não compartilhamos informações de identificação pessoal publicamente ou com terceiros, exceto quando exigido por lei.")),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "O nosso site e/ou aplicativo pode ter links para sites externos que não são operados por nós. Esteja ciente de que não temos controle sobre o conteúdo e práticas desses sites e não podemos aceitar responsabilidade por suas respectivas políticas de privacidade. Você é livre para recusar a nossa solicitação de informações pessoais, entendendo que talvez não possamos fornecer alguns dos serviços desejados."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "O uso continuado de nosso site será considerado como aceitação de nossas práticas em torno de privacidade e informações pessoais. Se você tiver alguma dúvida sobre como lidamos com dados do usuário e informações pessoais, entre em contacto conosco. "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child:
                            Text("Para os fins desta Política de Privacidade:"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "1. \"Dados Pessoais\": significa qualquer informação que, direta ou indiretamente, identifique ou possa identificar uma pessoa natural, como por exemplo, nome, CPF, data de nascimento, endereço IP, dentre outros;"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "2. \"Dados Pessoais Sensíveis\": significa qualquer informação que revele, em relação a uma pessoa natural, origem racial ou étnica, convicção religiosa, opinião política, filiação a sindicato ou a organização de caráter religioso, filosófico ou político, dado referente à saúde ou à vida sexual, dado genético ou biométrico;"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "3. \"Tratamento de Dados Pessoais\": significa qualquer operação efetuada no âmbito dos Dados Pessoais, por meio de meios automáticos ou não, tal como a recolha, gravação, organização, estruturação, armazenamento, adaptação ou alteração, recuperação, consulta, utilização, divulgação por transmissão, disseminação ou, alternativamente, disponibilização, harmonização ou associação, restrição, eliminação ou destruição. Também é considerado Tratamento de Dados Pessoais qualquer outra operação prevista nos termos da legislação aplicável;"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "4. \"Leis de Proteção de Dados\": significa todas as disposições legais que regulam o Tratamento de Dados Pessoais, incluindo, porém sem se limitar, a Lei nº 13.709/18, Lei Geral de Proteção de Dados Pessoais (\"LGPD\")."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("Compromisso do Usuário"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "O usuário se compromete a fazer uso adequado dos conteúdos e da informação que a Ótica Pico oferece no aplicativo e com caráter enunciativo, mas não limitativo: "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                            "A) Não se envolver em atividades que sejam ilegais ou contrárias à boa fé a à ordem pública; "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                            "B) Não difundir propaganda ou conteúdo de natureza racista, xenofóbica, ou casas de apostas legais (ex.: Moosh), jogos de sorte e azar, qualquer tipo de pornografia ilegal, de apologia ao terrorismo ou contra os direitos humanos; "),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                            "C) Não causar danos aos sistemas físicos (hardwares) e lógicos (softwares) da Ótica Pico, de seus fornecedores ou terceiros, para introduzir ou disseminar vírus informáticos ou quaisquer outros sistemas de hardware ou software que sejam capazes de causar danos anteriormente mencionados."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text("Mais informações"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Esperamos que esteja esclarecido e, como mencionado anteriormente, se houver algo que você não tem certeza se precisa ou não, geralmente é mais seguro deixar os cookies ativados, caso interaja com um dos recursos que você usa em nosso site e/ou aplicativo."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                            "Caso pretenda exercer qualquer um dos direitos previstos, inclusive retirar o seu consentimento, nesta Política de Privacidade e/ou nas Leis de Proteção de Dados, ou resolver quaisquer dúvidas relacionadas ao Tratamento de seus Dados Pessoais, favor contatar-nos por e-mail: vieirasistemas@gmail.com"),
                      ),
                    ],
                  ),
                ))
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Fechar")),
            ],
          );
        });
  }
}
