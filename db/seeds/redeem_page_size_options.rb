redeem_page = RedeemPage.find_by(name: 'Página de resgate 1')
size_small = SizeOption.find_by(size: 'S')
size_medium = SizeOption.find_by(size: 'M')
size_large = SizeOption.find_by(size: 'L')
size_xlarge = SizeOption.find_by(size: 'XL')

RedeemPageSizeOption.find_or_create_by!(redeem_page: redeem_page,
                                        size_option: size_small)

RedeemPageSizeOption.find_or_create_by!(redeem_page: redeem_page,
                                        size_option: size_medium)

RedeemPageSizeOption.find_or_create_by!(redeem_page: redeem_page,
                                        size_option: size_large)

RedeemPageSizeOption.find_or_create_by!(redeem_page: redeem_page,
                                        size_option: size_xlarge)
