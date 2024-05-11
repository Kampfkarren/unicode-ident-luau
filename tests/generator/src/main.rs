use std::io::{BufWriter, Write};

fn main() {
    let mut xid_start_file = BufWriter::new(std::fs::File::create("../xid_start.txt").unwrap());
    let mut xid_continue_file =
        BufWriter::new(std::fs::File::create("../xid_continue.txt").unwrap());

    for character_u32 in 0..=(char::MAX as u32) {
        let Some(character) = char::from_u32(character_u32) else {
            write!(xid_start_file, "X").unwrap();
            write!(xid_continue_file, "X").unwrap();
            continue;
        };

        write!(
            xid_start_file,
            "{}",
            if unicode_ident::is_xid_start(character) {
                'T'
            } else {
                'F'
            }
        )
        .unwrap();

        write!(
            xid_continue_file,
            "{}",
            if unicode_ident::is_xid_continue(character) {
                'T'
            } else {
                'F'
            }
        )
        .unwrap();
    }
}
