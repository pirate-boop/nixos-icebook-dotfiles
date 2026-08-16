nix = {
    settings = {
        substitures = ["https://ayugram-desktop.cachix.org"];
        trusted-public-keys = [
            "ayugram-desktop.cachix.org-1:AZ5EqHrJsAKL5YkZYLPEsb1FdD9QlypUwQ0REcJftgA="
        ];
    };
    extra-substitures = ["https://tg-owt.cachix.org"];
    extra-trusted-public-keys = [
        "tg-owt.cachix.org-1:lp0BukIhSK3EIyLcDhDZ5zAB0wr8w="        
