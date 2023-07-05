# ...

resource "random_id" "identifier" {
    keepers = {
    }
    byte_length = 8
}
