# appInnovaro

**Modelos**

* Clientes
* Recursos
* Forma de Pagamento
* Pedidos
* Vendedores
* Quantidade (QuantityCounter)
* Mensagem de Confirmação Custom (CustomConfirmationDialog)
* Forma de Pagamento (DadosPagamentoForm)
* ScamBar
* BarCode

**Páginas**

* FinalizaPedido
    * Campos de Pagamento (DadosPagamentoForm);
    * DescontoTotalNaNota - whidget

* itens_page (RecursosWidget);
* Header_page (payment_form_field);
* pagamento_page (payment_form_field);


**Repositorios**

* ClienteRepository
* RecursosRepository (RecursosService)
* Forma de Pagamento
* PagamentosRepository
* VendedoresRepository
* PedidoRepository
* Quantidade (QuantityCounter)
* Botão Adiciona Rascunho (ButtonLogic)
* RecursoRepository (RecursosService)
* DadosPagamentoRepository (DadosPagamentoController)

**Controladores**

* QuantidadeController (buttonQtdWidget)
* DadosPagamentoController
* RecursoController

**Classe Repository**

* NotificaçãoPedido (NotificationService)

**Features**

* Carrinho (ProductCard)

**Widgets**

* CardPedido
* CardRecursos
* AcanBar
* Quantidade (QuantityCounter)
* Mensagem de Confirmação Custom (CustomConfirmationDialog)

* **styles**
            * colors.dart
            * typography.dart
            * theme_configs.dart
        * **theme**
            * theme_configs.dart

* **main.dart**


**Explicação**

Aqui está uma explicação dos componentes do seu código em formato MD:

**Modelos**

Os modelos são classes que representam os dados do seu aplicativo. Eles são usados para armazenar informações sobre clientes, recursos, pedidos, Vendedores, etc.

**Páginas**

As páginas são as telas que são exibidas ao usuário. Elas são compostas por widgets e componentes de estilo.

**Repositorios**

Os repositórios são responsáveis por acessar e armazenar dados do aplicativo. Eles são usados para recuperar dados do banco de dados, da API ou de outros sistemas.

**Controladores**

Os controladores são responsáveis por lidar com as interações do usuário. Eles são usados para processar eventos, como cliques em botões ou preenchimento de formulários.

**Classe Repository**

A classe NotificationService é responsável por enviar notificações sobre novos pedidos.

**Features**

As features são recursos específicos do aplicativo. Elas podem incluir funcionalidades como o carrinho de compras, o checkout ou a navegação.

**Widgets**

Os widgets são componentes visuais que são usados para construir as páginas do aplicativo. Eles são usados para exibir texto, imagens, botões e outros elementos.

**Styles**

Os estilos são usados para definir a aparência do aplicativo. Eles podem ser usados para definir as cores, fontes e dimensões dos componentes.

Espero que isso ajude!
<!-- 
- **src**
    - **lib**
        - **models**
            - product.dart
            - cart_item.dart
        - **services**
            - api_service.dart
            - firebase_service.dart
        - **screens**
            - home_screen.dart
            - product_screen.dart
        - **widgets**
            - product_item.dart
            - cart_item.dart
            - custom_button.dart
        - **providers**
            - products_provider.dart
            - cart_provider.dart
        - **pages**
            - login_page.dart
            - home_page.dart
        - **components**
            - authentication
                - login_form.dart
                - registration_form.dart
            - firebase
                - firebase_auth.dart
                - firebase_storage.dart
            - drawers
                - app_drawer.dart
                - custom_drawer_item.dart
        - **styles**
            - colors.dart
            - typography.dart
            - theme_configs.dart
        - **theme**
            - theme_configs.dart
    - **main.dart**


Aqui está uma breve descrição de cada pasta e arquivo:

models/: Esta pasta contém os modelos de dados da sua aplicação, como Product (produto) e CartItem (item do carrinho).

services/: Aqui você pode colocar serviços relacionados à lógica de negócios, como um ApiService para fazer chamadas de API.

screens/: Esta pasta contém as telas do seu aplicativo. Por exemplo, HomeScreen (tela inicial), ProductScreen (tela do produto) e CartScreen (tela do carrinho).

widgets/: Aqui você pode armazenar widgets reutilizáveis que serão usados em várias telas, como ProductItem (item de produto), CartItem (item do carrinho) e CustomButton (botão personalizado).

providers/: Esta pasta contém os provedores de estado para gerenciar o estado global da aplicação. Por exemplo, ProductsProvider para gerenciar a lista de produtos e CartProvider para gerenciar o carrinho de compras.

pages/: Esta pasta contém as páginas específicas, como AuthPage e HomePage, que podem ser vinculadas a partir das telas principais.

components/: Aqui você pode organizar componentes reutilizáveis específicos para autenticação e Firebase. Por exemplo, na pasta authentication/, você pode ter LoginForm (formulário de login) e RegistrationForm (formulário de registro). Na pasta firebase/, você pode ter arquivos relacionados ao Firebase, como FirebaseAuth (autenticação com o Firebase) e FirebaseStorage (armazenamento no Firebase). Na pasta drawers/, você pode ter o AppDrawer (gaveta do aplicativo) e CustomDrawerItem (item personalizado da gaveta).

styles/: Aqui você pode definir arquivos relacionados a cores (colors.dart) e tipografia (typography.dart), que podem ser usados para manter um estilo consistente em todo o aplicativo.

theme/: Esta pasta contém arquivos relacionados à configuração do tema do aplicativo. Por exemplo, o arquivo theme_configs.dart pode conter as configurações de tema personalizado, como cores, fontes, estilos de botão, etc.

helpers/: Aqui você pode adicionar ajudantes (helpers) que fornecem funções auxiliares para tarefas comuns. Por exemplo, AuthenticationHelper pode conter funções para autenticação, como login, registro


main.dart: O ponto de entrada do seu aplicativo, onde você inicializa o Flutter e define a runApp.


### por favor amigues façam qualquer merge com a master fazendo um pull request
 -->
