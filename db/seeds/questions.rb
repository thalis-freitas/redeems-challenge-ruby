redeem_page = RedeemPage.find_by(name: 'Página de resgate 2')

Question.find_or_create_by!(redeem_page: redeem_page,
                            content: 'Qual é a sua cor favorita?')

Question.find_or_create_by!(redeem_page: redeem_page,
                            content: 'Fale um pouco sobre você.')
