// use std::ffi::CString;
// use std::os::raw::c_char;

// use super::sr25519;
// use super::util::{get_ptr, get_str};
// use ethsign::{keyfile::Crypto, Protected};
// use rustc_hex::{FromHex, FromHexError, ToHex};

// const CRYPTO_ITERATIONS: u32 = 10240;

// // binding encrypt decrypt to dart
// #[no_mangle]
// pub extern "C" fn encrypt_data(data: *const c_char, password: *const c_char) -> *mut c_char {
//     let password = Protected::new(get_str(password).into_bytes());
//     let result_crypto = Crypto::encrypt(&get_str(data).as_bytes(), &password, CRYPTO_ITERATIONS);
//     let crypto: Crypto = match result_crypto {
//         Ok(c) => c,
//         _ => return get_ptr(""),
//     };
//     let rust_string = serde_json::to_string(&crypto);
//     let cipher_text = match rust_string {
//         Ok(c) => c,
//         _ => String::from(""),
//     };
//     get_ptr(&cipher_text)
// }

// #[no_mangle]
// pub extern "C" fn decrypt_data(data: *const c_char, password: *const c_char) -> *mut c_char {
//     let password = Protected::new(get_str(password).into_bytes());

//     let result_crypto = serde_json::from_str(&get_str(data));
//     let crypto: Crypto = match result_crypto {
//         Ok(c) => c,
//         _ => return get_ptr(""),
//     };
//     let decrypted_result = crypto.decrypt(&password);
//     let decrypted = match decrypted_result {
//         Ok(c) => c,
//         _ => return get_ptr(""),
//     };
//     let rust_string = String::from_utf8(decrypted);
//     let result_string = match rust_string {
//         Ok(string) => string,
//         _ => String::from(""),
//     };
//     get_ptr(&result_string)
// }

// #[no_mangle]
// pub extern "C" fn substrate_address(suri: *const c_char, prefix: u8) -> *mut c_char {
//     let keypair_option = sr25519::KeyPair::from_suri(&get_str(suri));
//     let keypair = match keypair_option {
//         Some(c) => c,
//         _ => return get_ptr(""),
//     };

//     let rust_string = keypair.ss58_address(prefix);
//     get_ptr(&rust_string)
// }

// #[no_mangle]
// pub extern "C" fn substrate_sign(suri: *const c_char, text: *const c_char) -> *mut c_char {
//     let keypair_option = sr25519::KeyPair::from_suri(&get_str(suri));
//     let keypair = match keypair_option {
//         Some(c) => c,
//         _ => return get_ptr("keypair generation error"),
//     };
//     let text_string = get_str(text);
//     let message_result: Result<Vec<u8>, FromHexError> = text_string.from_hex();
//     let message: Vec<u8> = match message_result {
//         Ok(c) => c,
//         _ => return get_ptr(&get_str(text)),
//     };
//     let signature = keypair.sign(&message);
//     let result: String = signature.to_hex();
//     CString::new(result).unwrap().into_raw()
// }

// #[no_mangle]
// pub extern "C" fn schnorrkel_verify(
//     suri: *const c_char,
//     message: *const c_char,
//     signature: *const c_char,
// ) -> bool {
//     let keypair_option = sr25519::KeyPair::from_suri(&get_str(suri));
//     let keypair = match keypair_option {
//         Some(c) => c,
//         _ => return false,
//     };
//     let message_result: Result<Vec<u8>, FromHexError> = get_str(message).from_hex();
//     let original_message = match message_result {
//         Ok(c) => c,
//         _ => return false,
//     };
//     let signature_result: Result<Vec<u8>, FromHexError> = get_str(signature).from_hex();
//     let original_signature = match signature_result {
//         Ok(c) => c,
//         _ => return false,
//     };
//     return match keypair.verify_signature(&original_message, &original_signature) {
//         Some(result) => result,
//         _ => false,
//     };
// }

// #[no_mangle]
// pub extern "C" fn decrypt_data_with_ref(data: *const c_char, password: *const c_char) -> i64 {
//     let password = Protected::new(get_str(password).into_bytes());

//     let result_crypto = serde_json::from_str(&get_str(data));
//     let crypto: Crypto = match result_crypto {
//         Ok(c) => c,
//         _ => return 0,
//     };
//     let decrypted_result = crypto.decrypt(&password);
//     let decrypted = match decrypted_result {
//         Ok(c) => c,
//         _ => return 0,
//     };

//     let decrypted_ptr = Box::into_raw(Box::new(decrypted)) as i64;
//     return decrypted_ptr;
// }

// #[no_mangle]
// pub extern "C" fn substrate_sign_with_ref(
//     seed_ref: i64,
//     suri_suffix: *const c_char,
//     text: *const c_char,
// ) -> *mut c_char {
//     let seed = unsafe { Box::from_raw(seed_ref as *mut String) };
//     let suri_suffix_str = get_str(suri_suffix);
//     let suri = format!("{}{}", &seed, suri_suffix_str);
//     let keypair_option = sr25519::KeyPair::from_suri(&suri);
//     let keypair = match keypair_option {
//         Some(c) => c,
//         _ => return get_ptr("keypair generation error"),
//     };
//     let text_string = get_str(text);
//     let message_result: Result<Vec<u8>, FromHexError> = text_string.from_hex();
//     let message: Vec<u8> = match message_result {
//         Ok(c) => c,
//         _ => return get_ptr(&get_str(text)),
//     };
//     let signature = keypair.sign(&message);
//     let result: String = signature.to_hex();
//     let _ = Box::into_raw(seed) as i64;
//     CString::new(result).unwrap().into_raw()
// }

// #[no_mangle]
// pub extern "C" fn substrate_address_with_ref(
//     seed_ref: i64,
//     suri_suffix: *const c_char,
//     prefix: u8,
// ) -> *mut c_char {
//     let seed = unsafe { Box::from_raw(seed_ref as *mut String) };
//     let suri_suffix_str = get_str(suri_suffix);
//     let suri = format!("{}{}", &seed, suri_suffix_str);
//     let keypair_option = sr25519::KeyPair::from_suri(&suri);
//     let keypair = match keypair_option {
//         Some(c) => c,
//         _ => return get_ptr(""),
//     };
//     let _ = Box::into_raw(seed) as i64;
//     let rust_string = keypair.ss58_address(prefix);
//     get_ptr(&rust_string)
// }

// #[no_mangle]
// pub extern "C" fn destroy_data_ref(data_ref: i64) -> () {
//     unsafe { Box::from_raw(data_ref as *mut String) };
// }
