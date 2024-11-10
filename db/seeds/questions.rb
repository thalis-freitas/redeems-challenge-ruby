redeem_page1 = RedeemPage.find_by(name: 'Página de resgate 1')

Question.find_or_create_by!(redeem_page: redeem_page1,
                            content: 'Qual é a sua cor favorita?')

Question.find_or_create_by!(redeem_page: redeem_page1,
                            content: 'Fale um pouco sobre você.')
