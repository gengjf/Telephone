//
//  BundleReceipt.swift
//  Telephone
//
//  Copyright (c) 2008-2016 Alexey Kuznetsov
//  Copyright (c) 2016 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

final class BundleReceipt {
    fileprivate let bundle: Bundle
    fileprivate let gateway: ReceiptXPCGateway

    init(bundle: Bundle, gateway: ReceiptXPCGateway) {
        self.bundle = bundle
        self.gateway = gateway
    }
}

extension BundleReceipt: Receipt {
    func validate(completion: @escaping (ReceiptValidationResult) -> Void) {
        if let url = bundle.appStoreReceiptURL, let data = try? Data(contentsOf: url) {
            gateway.validateReceipt(data, completion: completion)
        } else {
            completion(.receiptIsInvalid)
        }
    }
}
