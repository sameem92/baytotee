// // DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// // This is a library that provides messages for a pt_BR locale. All the
// // messages from the main program should be duplicated here with the same
// // function name.
//
// // Ignore issues from commonly used lints in this file.
// // ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// // ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// // ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// // ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// // ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes
//
// import 'package:intl/intl.dart';
// import 'package:intl/message_lookup_by_library.dart';
//
// final messages = new MessageLookup();
//
// typedef String MessageIfAbsent(String messageStr, List<dynamic> args);
//
// class MessageLookup extends MessageLookupByLibrary {
//   String get localeName => 'pt_BR';
//
//   static String m0(id) => "Pedido: #${id} foi cancelado";
//
//   static String m1(name) => "The conversation with #${name} is dismissed";
//
//   static String m2(productName) =>
//       "O ${productName} foi removido do seu carrinho";
//
//   final messages = _notInlinedMessages(_notInlinedMessages);
//   static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
//         "about": MessageLookupByLibrary.simpleMessage("Sobre"),
//         "add": MessageLookupByLibrary.simpleMessage("Adicionar"),
//         "add_delivery_address": MessageLookupByLibrary.simpleMessage(
//             "Adicionar endereço de entrega"),
//         "add_new_delivery_address": MessageLookupByLibrary.simpleMessage(
//             "Adicionar novo endereço de entrega"),
//         "add_to_cart":
//             MessageLookupByLibrary.simpleMessage("Adicionar ao carrinho"),
//         "address": MessageLookupByLibrary.simpleMessage("Endereço"),
//         "addresses_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
//             "Endereços atualizados com sucesso"),
//         "all": MessageLookupByLibrary.simpleMessage("Todos"),
//         "all_product":
//             MessageLookupByLibrary.simpleMessage("Todos os produtos"),
//         "app_language":
//             MessageLookupByLibrary.simpleMessage("Idioma do aplicativo"),
//         "app_settings":
//             MessageLookupByLibrary.simpleMessage("Configurações do aplicativo"),
//         "application_preferences":
//             MessageLookupByLibrary.simpleMessage("Preferências do aplicativo"),
//         "apply_filters":
//             MessageLookupByLibrary.simpleMessage("Aplicar filtros"),
//         "areYouSureYouWantToCancelThisOrder":
//             MessageLookupByLibrary.simpleMessage(
//                 "Tem certeza de que deseja cancelar este pedido?"),
//         "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
//         "cancelOrder": MessageLookupByLibrary.simpleMessage("Cancelar pedido"),
//         "canceled": MessageLookupByLibrary.simpleMessage("Cancelado"),
//         "card_number": MessageLookupByLibrary.simpleMessage("NÚMERO DO CARTÃO"),
//         "cart": MessageLookupByLibrary.simpleMessage("Carrinho"),
//         "carts_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
//             "Carrinhos atualizados com sucesso"),
//         "cash_on_delivery":
//             MessageLookupByLibrary.simpleMessage("Dinheiro na entrega"),
//         "category": MessageLookupByLibrary.simpleMessage("Categoria"),
//         "category_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
//             "Categoria atualizada com sucesso"),
//         "checkout":
//             MessageLookupByLibrary.simpleMessage("Verificação de saída"),
//         "clear": MessageLookupByLibrary.simpleMessage("Claro"),
//         "clickOnTheProductToGetMoreDetailsAboutIt":
//             MessageLookupByLibrary.simpleMessage(
//                 "Clique no produto para obter mais detalhes sobre ele"),
//         "clickToPayWithRazorpayMethod": MessageLookupByLibrary.simpleMessage(
//             "Click to pay with RazorPay method"),
//         "click_on_the_stars_below_to_leave_comments":
//             MessageLookupByLibrary.simpleMessage(
//                 "Clique nas estrelas abaixo para deixar comentários"),
//         "click_to_confirm_your_address_and_pay_or_long_press":
//             MessageLookupByLibrary.simpleMessage(
//                 "Clique para confirmar seu endereço e pagar ou pressione e segure para editar seu endereço"),
//         "click_to_pay_cash_on_delivery": MessageLookupByLibrary.simpleMessage(
//             "Clique para pagar em dinheiro na entrega"),
//         "click_to_pay_on_pickup": MessageLookupByLibrary.simpleMessage(
//             "Clique para pagar na retirada"),
//         "click_to_pay_with_your_mastercard":
//             MessageLookupByLibrary.simpleMessage(
//                 "Clique para pagar com seu MasterCard"),
//         "click_to_pay_with_your_paypal_account":
//             MessageLookupByLibrary.simpleMessage(
//                 "Clique para pagar com sua conta do PayPal"),
//         "click_to_pay_with_your_visa_card":
//             MessageLookupByLibrary.simpleMessage(
//                 "Clique para pagar com seu cartão Visa"),
//         "close": MessageLookupByLibrary.simpleMessage("Fechar"),
//         "closed": MessageLookupByLibrary.simpleMessage("Fechadas"),
//         "completeYourProfileDetailsToContinue":
//             MessageLookupByLibrary.simpleMessage(
//                 "Preencha os detalhes do seu perfil para continuar"),
//         "confirm_payment":
//             MessageLookupByLibrary.simpleMessage("Confirme o pagamento"),
//         "confirm_your_delivery_address": MessageLookupByLibrary.simpleMessage(
//             "Confirme seu endereço de entrega"),
//         "confirmation": MessageLookupByLibrary.simpleMessage("Confirmação"),
//         "current_location":
//             MessageLookupByLibrary.simpleMessage("Localização atual"),
//         "cvc": MessageLookupByLibrary.simpleMessage("CVC"),
//         "cvv": MessageLookupByLibrary.simpleMessage("CVV"),
//         "dark_mode": MessageLookupByLibrary.simpleMessage("Modo escuro"),
//         "default_credit_card":
//             MessageLookupByLibrary.simpleMessage("Cartão de crédito padrão"),
//         "deliverable": MessageLookupByLibrary.simpleMessage("Entregável"),
//         "delivery": MessageLookupByLibrary.simpleMessage("Entrega"),
//         "deliveryAddressOutsideTheDeliveryRangeOfThisMarkets":
//             MessageLookupByLibrary.simpleMessage(
//                 "Endereço de entrega fora da faixa de entrega desses mercados."),
//         "deliveryMethodNotAllowed": MessageLookupByLibrary.simpleMessage(
//             "Método de entrega não permitido!"),
//         "delivery_address":
//             MessageLookupByLibrary.simpleMessage("Endereço de entrega"),
//         "delivery_address_removed_successfully":
//             MessageLookupByLibrary.simpleMessage(
//                 "Endereço de entrega removido com sucesso"),
//         "delivery_addresses":
//             MessageLookupByLibrary.simpleMessage("Endereços de entrega"),
//         "delivery_fee": MessageLookupByLibrary.simpleMessage("Taxa de entrega"),
//         "delivery_or_pickup":
//             MessageLookupByLibrary.simpleMessage("Entrega ou retirada"),
//         "description": MessageLookupByLibrary.simpleMessage("Descrição"),
//         "details": MessageLookupByLibrary.simpleMessage("Detalhes"),
//         "discover__explorer":
//             MessageLookupByLibrary.simpleMessage("Discover & Explorer"),
//         "dont_have_any_item_in_the_notification_list":
//             MessageLookupByLibrary.simpleMessage(
//                 "Não possui nenhum item na lista de notificações"),
//         "dont_have_any_item_in_your_cart": MessageLookupByLibrary.simpleMessage(
//             "Não tem nenhum item no seu carrinho"),
//         "edit": MessageLookupByLibrary.simpleMessage("Editar"),
//         "email": MessageLookupByLibrary.simpleMessage("O email"),
//         "email_address":
//             MessageLookupByLibrary.simpleMessage("Endereço de e-mail"),
//         "email_to_reset_password": MessageLookupByLibrary.simpleMessage(
//             "E-mail para redefinir a senha"),
//         "english": MessageLookupByLibrary.simpleMessage("Inglês"),
//         "error_verify_email_settings": MessageLookupByLibrary.simpleMessage(
//             "Erro! Verificar configurações de email"),
//         "exp_date": MessageLookupByLibrary.simpleMessage("Data de validade"),
//         "expiry_date": MessageLookupByLibrary.simpleMessage("DATA DE VALIDADE"),
//         "faq": MessageLookupByLibrary.simpleMessage("Perguntas frequentes"),
//         "faqsRefreshedSuccessfuly":
//             MessageLookupByLibrary.simpleMessage("Faqs refreshed successfully"),
//         "favorite_products":
//             MessageLookupByLibrary.simpleMessage("Produtos Favoritos"),
//         "favorites": MessageLookupByLibrary.simpleMessage("Favoritos"),
//         "favorites_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
//             "Favorites refreshed successfully"),
//         "featured_products":
//             MessageLookupByLibrary.simpleMessage("produtos em destaque"),
//         "fields": MessageLookupByLibrary.simpleMessage("Campos"),
//         "filter": MessageLookupByLibrary.simpleMessage("Filtro"),
//         "forMoreDetailsPleaseChatWithOurManagers":
//             MessageLookupByLibrary.simpleMessage(
//                 "For more details, please chat with our managers"),
//         "free": MessageLookupByLibrary.simpleMessage("Free"),
//         "full_address":
//             MessageLookupByLibrary.simpleMessage("Endereço completo"),
//         "full_name": MessageLookupByLibrary.simpleMessage("Nome completo"),
//         "guest": MessageLookupByLibrary.simpleMessage("Hóspede"),
//         "haveCouponCode":
//             MessageLookupByLibrary.simpleMessage("Have Coupon Code?"),
//         "help__support":
//             MessageLookupByLibrary.simpleMessage("Ajuda e Suporte"),
//         "help_support": MessageLookupByLibrary.simpleMessage("Ajuda e Suporte"),
//         "help_supports":
//             MessageLookupByLibrary.simpleMessage("Ajuda e Suporte"),
//         "hint_full_address": MessageLookupByLibrary.simpleMessage(
//             "12 Street, Cidade 21663, País"),
//         "home": MessageLookupByLibrary.simpleMessage("Casa"),
//         "home_address":
//             MessageLookupByLibrary.simpleMessage("Endereço residencial"),
//         "how_would_you_rate_this_market": MessageLookupByLibrary.simpleMessage(
//             "Como você classificaria esse mercado?"),
//         "how_would_you_rate_this_market_": MessageLookupByLibrary.simpleMessage(
//             "Como você classificaria esse mercado?"),
//         "i_dont_have_an_account":
//             MessageLookupByLibrary.simpleMessage("Eu não tenho uma conta?"),
//         "i_forgot_password":
//             MessageLookupByLibrary.simpleMessage("Esqueci minha senha?"),
//         "i_have_account_back_to_login": MessageLookupByLibrary.simpleMessage(
//             "Eu tenho conta Volte ao login"),
//         "i_remember_my_password_return_to_login":
//             MessageLookupByLibrary.simpleMessage(
//                 "Lembro-me da minha senha voltar ao login"),
//         "information": MessageLookupByLibrary.simpleMessage("Em formação"),
//         "invalidCouponCode":
//             MessageLookupByLibrary.simpleMessage("Invalid Coupon"),
//         "items": MessageLookupByLibrary.simpleMessage("Itens"),
//         "john_doe": MessageLookupByLibrary.simpleMessage("John Doe"),
//         "keep_your_old_meals_of_this_market":
//             MessageLookupByLibrary.simpleMessage(
//                 "Mantenha as suas refeições antigas deste mercado"),
//         "km": MessageLookupByLibrary.simpleMessage("Km"),
//         "languages": MessageLookupByLibrary.simpleMessage("línguas"),
//         "lets_start_with_login":
//             MessageLookupByLibrary.simpleMessage("Vamos começar com o login!"),
//         "lets_start_with_register": MessageLookupByLibrary.simpleMessage(
//             "Vamos começar com o registro!"),
//         "light_mode": MessageLookupByLibrary.simpleMessage("Modo de luz"),
//         "log_out": MessageLookupByLibrary.simpleMessage("Sair"),
//         "login": MessageLookupByLibrary.simpleMessage("Conecte-se"),
//         "loginAccountOrCreateNewOneForFree":
//             MessageLookupByLibrary.simpleMessage(
//                 "Login account or create new one for free"),
//         "long_press_to_edit_item_swipe_item_to_delete_it":
//             MessageLookupByLibrary.simpleMessage(
//                 "Pressione e segure para editar o item, deslize o item para excluí-lo"),
//         "makeItDefault":
//             MessageLookupByLibrary.simpleMessage("Make it default"),
//         "maps_explorer": MessageLookupByLibrary.simpleMessage("Maps Explorer"),
//         "market_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
//             "Mercado atualizado com sucesso"),
//         "markets_near_to":
//             MessageLookupByLibrary.simpleMessage("Mercados próximos a"),
//         "markets_near_to_your_current_location":
//             MessageLookupByLibrary.simpleMessage(
//                 "Mercados próximos à sua localização atual"),
//         "markets_results":
//             MessageLookupByLibrary.simpleMessage("Resultados de Mercados"),
//         "mastercard": MessageLookupByLibrary.simpleMessage("MasterCard"),
//         "messages": MessageLookupByLibrary.simpleMessage("Messages"),
//         "mi": MessageLookupByLibrary.simpleMessage("mi"),
//         "most_popular": MessageLookupByLibrary.simpleMessage("Mais popular"),
//         "my_orders": MessageLookupByLibrary.simpleMessage("minhas ordens"),
//         "near_to": MessageLookupByLibrary.simpleMessage("Perto de"),
//         "near_to_your_current_location": MessageLookupByLibrary.simpleMessage(
//             "Perto da sua localização atual"),
//         "newMessageFrom":
//             MessageLookupByLibrary.simpleMessage("New message from"),
//         "new_address_added_successfully": MessageLookupByLibrary.simpleMessage(
//             "Novo endereço adicionado com sucesso"),
//         "new_order_from_client":
//             MessageLookupByLibrary.simpleMessage("Novo pedido do cliente"),
//         "notValidAddress":
//             MessageLookupByLibrary.simpleMessage("Not valid address"),
//         "notValidAddressDescription": MessageLookupByLibrary.simpleMessage(
//             "Not valid address description"),
//         "not_a_valid_address":
//             MessageLookupByLibrary.simpleMessage("Endereço inválido"),
//         "not_a_valid_biography":
//             MessageLookupByLibrary.simpleMessage("Biografia não válida"),
//         "not_a_valid_cvc": MessageLookupByLibrary.simpleMessage("CVC inválido"),
//         "not_a_valid_date":
//             MessageLookupByLibrary.simpleMessage("Data não válida"),
//         "not_a_valid_email":
//             MessageLookupByLibrary.simpleMessage("Não é um email válido"),
//         "not_a_valid_full_name": MessageLookupByLibrary.simpleMessage(
//             "Não é um nome completo válido"),
//         "not_a_valid_number":
//             MessageLookupByLibrary.simpleMessage("Não é um número válido"),
//         "not_a_valid_phone":
//             MessageLookupByLibrary.simpleMessage("Não é um telefone válido"),
//         "not_deliverable": MessageLookupByLibrary.simpleMessage("Não entregue"),
//         "notificationWasRemoved":
//             MessageLookupByLibrary.simpleMessage("Notification was removed"),
//         "notifications": MessageLookupByLibrary.simpleMessage("Notificações"),
//         "notifications_refreshed_successfuly":
//             MessageLookupByLibrary.simpleMessage(
//                 "Notificações atualizadas com sucesso"),
//         "number": MessageLookupByLibrary.simpleMessage("Número"),
//         "oneOrMoreProductsInYourCartNotDeliverable":
//             MessageLookupByLibrary.simpleMessage(
//                 "Um ou mais produtos no seu carrinho não podem ser entregues."),
//         "open": MessageLookupByLibrary.simpleMessage("Aberto"),
//         "opened_markets":
//             MessageLookupByLibrary.simpleMessage("Mercados Abertos"),
//         "options": MessageLookupByLibrary.simpleMessage("Opções"),
//         "or_checkout_with":
//             MessageLookupByLibrary.simpleMessage("Ou check-out com"),
//         "order": MessageLookupByLibrary.simpleMessage("Ordem"),
//         "orderDetails":
//             MessageLookupByLibrary.simpleMessage("detalhes do pedido"),
//         "orderThisorderidHasBeenCanceled": m0,
//         "order_id": MessageLookupByLibrary.simpleMessage("ID do pedido"),
//         "order_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
//             "Pedido atualizado com sucesso"),
//         "order_status_changed":
//             MessageLookupByLibrary.simpleMessage("Status do pedido alterado"),
//         "ordered_by_nearby_first":
//             MessageLookupByLibrary.simpleMessage("Ordenado por Perto primeiro"),
//         "orders_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
//             "Pedidos atualizados com sucesso"),
//         "password": MessageLookupByLibrary.simpleMessage("Senha"),
//         "pay_on_pickup":
//             MessageLookupByLibrary.simpleMessage("Pagar na retirada"),
//         "payment_card_updated_successfully":
//             MessageLookupByLibrary.simpleMessage(
//                 "Cartão de pagamento atualizado com sucesso"),
//         "payment_mode":
//             MessageLookupByLibrary.simpleMessage("Modo de pagamento"),
//         "payment_options":
//             MessageLookupByLibrary.simpleMessage("Opções de pagamento"),
//         "payment_settings":
//             MessageLookupByLibrary.simpleMessage("Configurações de pagamento"),
//         "payment_settings_updated_successfully":
//             MessageLookupByLibrary.simpleMessage(
//                 "Configurações de pagamento atualizadas com sucesso"),
//         "payments_settings":
//             MessageLookupByLibrary.simpleMessage("Configurações de pagamentos"),
//         "paypal": MessageLookupByLibrary.simpleMessage("PayPal"),
//         "paypal_payment":
//             MessageLookupByLibrary.simpleMessage("Pagamento PayPal"),
//         "phone": MessageLookupByLibrary.simpleMessage("telefone"),
//         "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
//         "pickup": MessageLookupByLibrary.simpleMessage("Pegar"),
//         "pickup_your_product_from_the_market":
//             MessageLookupByLibrary.simpleMessage(
//                 "Retire seu produto do mercado"),
//         "productRefreshedSuccessfuly": MessageLookupByLibrary.simpleMessage(
//             "Product refreshed successfully"),
//         "product_categories":
//             MessageLookupByLibrary.simpleMessage("Categorias de Produtos"),
//         "products": MessageLookupByLibrary.simpleMessage("Products"),
//         "products_result":
//             MessageLookupByLibrary.simpleMessage("Resultado dos produtos"),
//         "products_results":
//             MessageLookupByLibrary.simpleMessage("Resultados dos produtos"),
//         "profile": MessageLookupByLibrary.simpleMessage("Perfil"),
//         "profile_settings":
//             MessageLookupByLibrary.simpleMessage("Configurações de perfil"),
//         "profile_settings_updated_successfully":
//             MessageLookupByLibrary.simpleMessage(
//                 "Configurações de perfil atualizadas com sucesso"),
//         "quantity": MessageLookupByLibrary.simpleMessage("Quantidade"),
//         "razorpay": MessageLookupByLibrary.simpleMessage("RazorPay"),
//         "razorpayPayment":
//             MessageLookupByLibrary.simpleMessage("RazorPay Payment"),
//         "recent_orders":
//             MessageLookupByLibrary.simpleMessage("pedidos recentes"),
//         "recent_reviews":
//             MessageLookupByLibrary.simpleMessage("Comentários recentes"),
//         "recents_search":
//             MessageLookupByLibrary.simpleMessage("Pesquisa recente"),
//         "register": MessageLookupByLibrary.simpleMessage("Registro"),
//         "reset": MessageLookupByLibrary.simpleMessage("Redefinir"),
//         "reset_cart":
//             MessageLookupByLibrary.simpleMessage("Redefinir carrinho?"),
//         "reset_your_cart_and_order_meals_form_this_market":
//             MessageLookupByLibrary.simpleMessage(
//                 "Redefina seu carrinho e solicite refeições deste mercado"),
//         "reviews": MessageLookupByLibrary.simpleMessage("Avaliações"),
//         "reviews_refreshed_successfully": MessageLookupByLibrary.simpleMessage(
//             "Comentários atualizados com sucesso!"),
//         "save": MessageLookupByLibrary.simpleMessage("Salve"),
//         "search": MessageLookupByLibrary.simpleMessage("Procurar"),
//         "search_for_markets_or_products": MessageLookupByLibrary.simpleMessage(
//             "Pesquise mercados ou produtos"),
//         "select_options_to_add_them_on_the_product":
//             MessageLookupByLibrary.simpleMessage(
//                 "Selecione opções para adicioná-los ao produto"),
//         "select_your_preferred_languages": MessageLookupByLibrary.simpleMessage(
//             "Selecione seus idiomas preferidos"),
//         "select_your_preferred_payment_mode":
//             MessageLookupByLibrary.simpleMessage(
//                 "Selecione seu modo de pagamento preferido"),
//         "send_password_reset_link":
//             MessageLookupByLibrary.simpleMessage("Enviar Link"),
//         "settings": MessageLookupByLibrary.simpleMessage("Definições"),
//         "shopping": MessageLookupByLibrary.simpleMessage("Compras"),
//         "shopping_cart":
//             MessageLookupByLibrary.simpleMessage("Carrinho de compras"),
//         "should_be_a_valid_email":
//             MessageLookupByLibrary.simpleMessage("Deve ser um email válido"),
//         "should_be_more_than_3_characters":
//             MessageLookupByLibrary.simpleMessage(
//                 "Deve ter mais de 3 caracteres"),
//         "should_be_more_than_3_letters":
//             MessageLookupByLibrary.simpleMessage("Deve ter mais de 3 letras"),
//         "should_be_more_than_6_letters":
//             MessageLookupByLibrary.simpleMessage("Deve ter mais de 6 letras"),
//         "signinToChatWithOurManagers": MessageLookupByLibrary.simpleMessage(
//             "Sign-In to chat with our managers"),
//         "skip": MessageLookupByLibrary.simpleMessage("Pular"),
//         "smsHasBeenSentTo":
//             MessageLookupByLibrary.simpleMessage("SMS has been sent to"),
//         "start_exploring":
//             MessageLookupByLibrary.simpleMessage("Comece a explorar"),
//         "submit": MessageLookupByLibrary.simpleMessage("Enviar"),
//         "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
//         "swipeLeftTheNotificationToDeleteOrReadUnreadIt":
//             MessageLookupByLibrary.simpleMessage(
//                 "Swipe left the notification to delete or read / unread it"),
//         "tapAgainToLeave":
//             MessageLookupByLibrary.simpleMessage("Tap again to leave"),
//         "tax": MessageLookupByLibrary.simpleMessage("Imposto"),
//         "tell_us_about_this_market": MessageLookupByLibrary.simpleMessage(
//             "Conte-nos sobre este mercado"),
//         "tell_us_about_this_product": MessageLookupByLibrary.simpleMessage(
//             "Nos conte sobre este produto"),
//         "theConversationWithIsDismissed": m1,
//         "the_address_updated_successfully":
//             MessageLookupByLibrary.simpleMessage(
//                 "O endereço foi atualizado com sucesso"),
//         "the_market_has_been_rated_successfully":
//             MessageLookupByLibrary.simpleMessage(
//                 "O mercado foi avaliado com sucesso"),
//         "the_product_has_been_rated_successfully":
//             MessageLookupByLibrary.simpleMessage(
//                 "O produto foi classificado com sucesso"),
//         "the_product_was_removed_from_your_cart": m2,
//         "thisMarketNotSupportDeliveryMethod":
//             MessageLookupByLibrary.simpleMessage(
//                 "Este mercado não suporta o método de entrega."),
//         "thisNotificationHasMarkedAsRead": MessageLookupByLibrary.simpleMessage(
//             "This notification has marked as read"),
//         "thisNotificationHasMarkedAsUnread":
//             MessageLookupByLibrary.simpleMessage(
//                 "This notification has marked as unread"),
//         "thisProductWasAddedToFavorite": MessageLookupByLibrary.simpleMessage(
//             "This product was added to favorite"),
//         "thisProductWasRemovedFromFavorites":
//             MessageLookupByLibrary.simpleMessage(
//                 "This product was removed from favorites"),
//         "this_account_not_exist":
//             MessageLookupByLibrary.simpleMessage("Esta conta não existe"),
//         "this_email_account_exists":
//             MessageLookupByLibrary.simpleMessage("Esta conta de email existe"),
//         "this_market_is_closed_":
//             MessageLookupByLibrary.simpleMessage("Este mercado está fechado!"),
//         "this_product_was_added_to_cart": MessageLookupByLibrary.simpleMessage(
//             "Este produto foi adicionado ao carrinho"),
//         "top_markets":
//             MessageLookupByLibrary.simpleMessage("Principais mercados"),
//         "total": MessageLookupByLibrary.simpleMessage("Total"),
//         "tracking_order":
//             MessageLookupByLibrary.simpleMessage("Ordem de rastreamento"),
//         "tracking_refreshed_successfuly": MessageLookupByLibrary.simpleMessage(
//             "Rastreamento atualizado com sucesso"),
//         "trending_this_week":
//             MessageLookupByLibrary.simpleMessage("Tendências desta semana"),
//         "typeToStartChat":
//             MessageLookupByLibrary.simpleMessage("Type to start chat"),
//         "unknown": MessageLookupByLibrary.simpleMessage("Desconhecido"),
//         "validCouponCode": MessageLookupByLibrary.simpleMessage("Valid Coupon"),
//         "verify": MessageLookupByLibrary.simpleMessage("Verificar"),
//         "verifyPhoneNumber":
//             MessageLookupByLibrary.simpleMessage("Verify Phone Number"),
//         "verify_your_internet_connection": MessageLookupByLibrary.simpleMessage(
//             "Verifique sua conexão com a Internet"),
//         "verify_your_quantity_and_click_checkout":
//             MessageLookupByLibrary.simpleMessage(
//                 "Verifique sua quantidade e clique em check-out"),
//         "version": MessageLookupByLibrary.simpleMessage("Versão"),
//         "view": MessageLookupByLibrary.simpleMessage("Visão"),
//         "viewDetails": MessageLookupByLibrary.simpleMessage("Ver detalhes"),
//         "visa_card": MessageLookupByLibrary.simpleMessage("Cartão Visa"),
//         "weAreSendingOtpToValidateYourMobileNumberHang":
//             MessageLookupByLibrary.simpleMessage(
//                 "We are sending OTP to validate your mobile number. Hang on!"),
//         "welcome": MessageLookupByLibrary.simpleMessage("Bem-vinda"),
//         "what_they_say":
//             MessageLookupByLibrary.simpleMessage("O que eles disseram ?"),
//         "wrong_email_or_password":
//             MessageLookupByLibrary.simpleMessage("e-mail ou senha incorretos"),
//         "yes": MessageLookupByLibrary.simpleMessage("sim"),
//         "youDontHaveAnyConversations": MessageLookupByLibrary.simpleMessage(
//             "You don\'t have any conversations"),
//         "youDontHaveAnyOrder":
//             MessageLookupByLibrary.simpleMessage("Você não tem nenhum pedido"),
//         "you_can_discover_markets": MessageLookupByLibrary.simpleMessage(
//             "Você pode descobrir mercados e lojas ao seu redor e escolher sua melhor refeição após alguns minutos, nós preparamos e entregamos para você"),
//         "you_must_add_products_of_the_same_markets_choose_one":
//             MessageLookupByLibrary.simpleMessage(
//                 "Você deve adicionar produtos dos mesmos mercados, escolher apenas um mercado!"),
//         "you_must_signin_to_access_to_this_section":
//             MessageLookupByLibrary.simpleMessage(
//                 "Você deve fazer login para acessar esta seção"),
//         "your_address": MessageLookupByLibrary.simpleMessage("Seu endereço"),
//         "your_biography": MessageLookupByLibrary.simpleMessage("Sua biografia"),
//         "your_credit_card_not_valid": MessageLookupByLibrary.simpleMessage(
//             "O seu cartão de crédito não é válido"),
//         "your_order_has_been_successfully_submitted":
//             MessageLookupByLibrary.simpleMessage(
//                 "Seu pedido foi enviado com sucesso!"),
//         "your_reset_link_has_been_sent_to_your_email":
//             MessageLookupByLibrary.simpleMessage(
//                 "Seu link de redefinição foi enviado para seu e-mail")
//       };
// }
