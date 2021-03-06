//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Amplify

public class AWSAuthConfirmResetPasswordOperation: AmplifyOperation<
    AuthConfirmResetPasswordRequest,
    Void,
    AuthError
>, AuthConfirmResetPasswordOperation {

    let authenticationProvider: AuthenticationProviderBehavior

    init(_ request: AuthConfirmResetPasswordRequest,
         authenticationProvider: AuthenticationProviderBehavior,
         resultListener: ResultListener?) {

        self.authenticationProvider = authenticationProvider
        super.init(categoryType: .auth,
                   eventName: HubPayload.EventName.Auth.confirmResetPasswordAPI,
                   request: request,
                   resultListener: resultListener)
    }

    override public func main() {
        if isCancelled {
            finish()
            return
        }

        if let validationError = request.hasError() {
            dispatch(validationError)
            finish()
            return
        }
        authenticationProvider.confirmResetPassword(request: request) { [weak self] result in
            guard let self = self else { return }

            defer {
                self.finish()
            }

            if self.isCancelled {
                return
            }

            switch result {
            case .failure(let error):
                self.dispatch(error)
            case .success:
                self.dispatchSuccess()
            }
        }
    }

    private func dispatchSuccess() {
        let result = OperationResult.success(())
        dispatch(result: result)
    }

    private func dispatch(_ error: AuthError) {
        let result = OperationResult.failure(error)
        dispatch(result: result)
    }
}
