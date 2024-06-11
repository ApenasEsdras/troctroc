
## Configuração do Firebase Cloud Functions

1. **Baixar e instalar o Firebase CLI:**
   - Baixe e instale o Firebase CLI seguindo os passos da documentação: [CLI do Firebase](https://firebase.google.com/docs/cli?hl=pt-br).
   - Atualize as políticas de execução no Windows 11 com o comando:

   ```terminal
    Set-ExecutionPolicy RemoteSigned
   ```

2. **Configurar o Path do FlutterFire no sistema:**
   - Coloque o caminho do FlutterFire no path do sistema e não do usuário.

3. **Fazer login na conta Google:**
   - Faça login na sua conta Google autorizada:

   ```.
   firebase login
   ```

4. **Acessar a pasta das Cloud Functions:**
   - Entre na pasta das funções:

   ```.
   cd functions
   ```

5. **Instalar as dependências Node.js:**
   - Instale as dependências:

   ```.
   npm i
   ``` 

6. **Fazer build das funções:**
   - Gerar a biblioteca:

    ```.
   npm run build
   ```

7. **Configurar e iniciar um emulador para testes:**
   - Criar emulador: `firebase init emulator` (permita todas as portas).
   - Iniciar emulador:

   ```.
   firebase emulators:start
   ```

   - Acessar emulador:

   ```.
   http://127.0.0.1:4000/
   ```

8. **Configurar o aplicativo Flutter para usar o emulador:**
   - Adicionar no `main.dart`:

     ```dart
     if (kDebugMode) {
       try {
         FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
         await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
       } catch (e) {
         print(e);
       }
     }
     ```

9. **Deploy das funções no Firebase:**
   - Cadastrar um securet: $ firebase functions:secrets:set TOKEN
   - Cadastrar um securet: $ firebase functions:secrets:set API_URL
      - colocar o valor do secret e pronto secret criado
      
   - Deploy de todas as funções: `irebase deploy --only functions`.
   - Deploy de funções específicas: `firebase deploy --only functions:lerGravaClientes`.

10. **Permissões no Firebase:**
    - Solicitar permissão de "Cloud Functions Admin" no [Console do Google Cloud](https://console.cloud.google.com/iam-admin/iam?project).

## Mudar entre projetos no Firebase CLI

1. **Usando o comando firebase projects:use:**
   - <https://firebase.google.com/docs/cli?hl=pt-br>
   - Listar todos os projetos:

    ```terminal
   firebase projects:list
   ```

   - Usar projeto específico:

    ```terminal
   firebase use --add 
   ```

- depois é só escolher em qual porjeto vc quer conectar

**Recursos adicionais:**

- Documentação da CLI do Firebase: [CLI do Firebase](https://firebase.google.com/docs/cli).

## Observações sobre os Bancos de Dados

- Os bancos de dados devem ser criados na região `us-east1` (South Carolina).


exemplo de scadules
https://us-central1-app-innovaro-mci.cloudfunctions.net/lerGravaClientes
*/10 6-19 * * *
   
https://us-central1-app-innovaro-mci.cloudfunctions.net/lerGravaRecursos
*/10 6-19 * * *

https://us-central1-app-innovaro-mci.cloudfunctions.net/lerGravaCondicoesDePagamento
8,12,16 6-18 * * 1-6

https://us-central1-app-innovaro-mci.cloudfunctions.net/lerGravaEstabelecimentos
8,12,16 6-18 * * 1-6
---
