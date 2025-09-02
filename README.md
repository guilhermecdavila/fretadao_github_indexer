# README

- [Desenvolvimento](#desenvolvimento)
- [Imagens](#imagens)
- [Bibliotecas e Tecnologias escolhidas](#bibliotecas-e-tecnologias-escolhidas)
- [Patterns utilizados](#patterns-utilizados)
- [Melhorias](#melhorias)


sudo docker pull docker.elastic.co/elasticsearch/elasticsearch:7.17.28

sudo docker run -p 9500:9200 -p 9600:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.17.28



sudo -u postgres createuser -s dev -p 5433
sudo -u postgres psql -p 5433


\password dev

qwerty
qwerty

### Desenvolvimento

* O projeto é baseado principalmente na arquitetura MVC do Rails.
* A chamada para o webscrapper é feita utilizando um service para remover a lógica do model.
* Foi utilizado concern para tratar códigos relacionados ao searchkick.
* As queries estão separadas na pasta query onde é tratado a busca e parametrização do elastic search.
* O filtro para enviar os dados ao controller está separado na pasta filter, tentei deixar o controller mais enxuto possível.
* O código foi implementado com o uso das gems RSpec (para criação dos testes unitários) e VCR, para reutilizar os dados para api's externas.

### Imagens

* **Tela principal**

<img src="/public/prints/index.png">

* **Exibe um perfil**

<img src="/public/prints/show.png">

* **Busca todos**

<img src="/public/prints/search-all.png">

* **Busca especifica**

<img src="/public/prints/search-guilherme.png">

* **Tela novo registro**

<img src="/public/prints/new-with-validation.png">

* **Tela editar registro**

<img src="/public/prints/edit.png">

* **Botão excluir registro**

<img src="/public/prints/destroy.png">

* **Botão escanear**

<img src="/public/prints/rescan.png">

### Bibliotecas e Tecnologias escolhidas

* **Postgres**

Foi utilizado postgresql como escolha para banco de dados por apresentar as seguintes caracteristicas:

* Robustez e confiabilidade: É um dos bancos de dados mais estáveis e confiáveis do mercado, utilizado por grandes empresas.
* Recursos avançados: Suporta transações ACID, índices avançados, JSON, arrays, funções, views, triggers e muito mais.
* Escalabilidade: Lida bem com grandes volumes de dados e múltiplos usuários simultâneos.
* Open source: É gratuito e possui uma comunidade ativa, com atualizações constantes e suporte a novas funcionalidades.
* Performance: Oferece excelente desempenho para consultas complexas e operações de leitura/escrita.

* **Sweet Alert**

Implementado no projeto para melhorar a visualização das mensagens do flash_messages. As vantagens de usar essa biblioteca são:

* Interface moderna e personalizável: Permite criar alertas bonitos, com cores, ícones e botões customizados, melhorando a experiência do usuário.
* Facilidade de integração: É fácil de adicionar ao projeto e de utilizar nos códigos JavaScript.
* Alertas interativos: Suporta ações como confirmação, cancelamento e múltiplos botões, tornando as notificações mais dinâmicas.
* Melhora a usabilidade: Substitui os alertas padrão do navegador por pop-ups mais intuitivos e agradáveis visualmente.
* Compatibilidade: Funciona bem em diferentes navegadores e dispositivos.

* **Elasticsearch**

Foi utilizado Elasticsearch como serviço de busca devido as principais vantagens listadas a seguir:

* Busca full-text eficiente: Permite realizar buscas avançadas por texto, com relevância, sugestões e tolerância a erros de digitação.
* Alta performance: É otimizado para consultas rápidas, mesmo com grandes volumes de dados.
* Escalabilidade: Suporta crescimento horizontal, podendo ser distribuído em vários servidores.
* Filtros e agregações: Permite criar filtros complexos e gerar estatísticas dos dados de forma simples.
* Facilidade de configuração: Pode ser configurado rapidamente para diferentes tipos de dados e necessidades de busca.
* Atualização em tempo real: Indexa e atualiza dados rapidamente, refletindo mudanças quase instantaneamente nas buscas.

Como biblioteca, foi escolhido a gem searchkick por apresentar como principais características configuração flexivel, alta performance, atualização automática dos indices e possui uma excelente documentação e uma comunidade ativa.

* **Fontawesome**

Implementado no projeto para estilizar com icones botões e telas, a fim de garantir elegância e objetividade nas funcionalidades do projeto. As vantagens de usar essa biblioteca são:

* Grande variedade de ícones: Oferece milhares de ícones prontos para uso em diferentes contextos.
* Facilidade de integração: Basta incluir a biblioteca no projeto para começar a usar os ícones com classes CSS.
* Personalização: Permite alterar cor, tamanho, animação e outros estilos facilmente via CSS.
* Ícones vetoriais: Mantêm a qualidade em qualquer resolução e tamanho, sem perder nitidez.
* Performance: Os ícones carregam rapidamente, pois são leves e otimizados.
Compatibilidade: Funciona bem em todos os navegadores modernos e dispositivos.

* **Tailwind**

Implementado no projeto para atender a parte visual do usuário, aplicando responsividade e elegância. As vantagens de usar essa biblioteca são:

* Produtividade: Permite criar layouts rapidamente usando classes utilitárias, sem precisar escrever CSS personalizado para cada componente.
* Personalização fácil: Facilita a customização do design diretamente no HTML, tornando ajustes visuais mais ágeis.
* Design consistente: Garante padronização visual em todo o projeto, evitando estilos conflitantes.
* Responsividade: Possui classes prontas para adaptar o layout a diferentes tamanhos de tela.
* Performance: Gera CSS enxuto, eliminando estilos não utilizados e melhorando o tempo de carregamento.
* Comunidade ativa: Conta com documentação completa e muitos exemplos, facilitando o aprendizado e a resolução de dúvidas.

* **WATIR - Webscrapper**

Para fazer o webscrapper foi escolhido a biblioteca WATIR que utiliza a gem selenium-webdriver para mapear sites e pegar as informações importantes listadas no desafio. Essa biblioteca apresenta como principais caracteristicas:

* Automação de navegador fácil: Permite controlar navegadores (Chrome, Firefox, Edge, etc.) de forma simples usando Ruby.
* Sintaxe intuitiva: O código é fácil de ler e escrever, tornando a automação acessível até para iniciantes.
* Suporte a múltiplos navegadores: Funciona com diversos navegadores sem grandes mudanças no código.
* Interação avançada: Permite clicar, preencher formulários, navegar entre páginas, validar elementos e muito mais.
* Integração com outras ferramentas: Pode ser usada junto com RSpec, Capybara e outras gems de teste.

* **Encurtador de URL**

Foi utilizado a gem tinyurl_shortener

Vantagens

* Facilidade de uso: Permite encurtar URLs com apenas uma linha de código, sem necessidade de implementar integração manual com APIs externas.
* Integração rápida: Já vem pronta para uso em projetos Ruby/Rails, agilizando o desenvolvimento.
* Redução do tamanho das URLs: Gera links curtos, facilitando o compartilhamento e melhorando a aparência em interfaces.
* Sem custo adicional: Utiliza o serviço TinyURL, que é gratuito para uso básico.
* Evita dependências externas: Não é necessário criar sua própria lógica de encurtamento ou manter um serviço próprio.


### Patterns utilizados

* Form Object
* Service Object
* Concern/Indexes
* Searchs


### Melhorias

* **Dockerizar:** o projeto para facilitar a gestão do ambiente de desenvolvimento, além de melhorar a escalabilidade e o gerenciamento das dependências do sistema, criando um fluxo de trabalho mais eficiente tanto para desenvolvimento quanto para deploy em produção.

* **Webscraper:** Durante o desenvolvimento do projeto, utilizamos a gem Nokogiri para extrair atributos do perfil do GitHub. Inicialmente, os testes passaram sem problemas, pois o perfil escolhido não possuía contribuições no último ano. No entanto, ao testar com um perfil que possuía contribuições maiores que zero, um erro ocorreu. Descobrimos que o atributo last_year_contributions é carregado de forma assíncrona, e o GitHub utiliza um *include-fragment* com um src dinâmico, impedindo a extração direta do conteúdo. Para solucionar esse problema, uma abordagem seria utilizar a gem **selenium-webdriver**, permitindo carregar o conteúdo dinamicamente antes da extração dos dados.