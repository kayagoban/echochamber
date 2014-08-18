echochamber
===========

Ruby Gem to consume Adobe's EchoSign e-signature service


## Installation

```
gem install echochamber
```

## Usage

#### Initializing a client

```
credentials = Echochamber::Credentials.new(app_id, app_secret, api_key, email, password)

client = Echochamber::Client.new(credentials)
```

#### Creating a user

```
user_params = {
      firstName:  'JohnQ',
      lastName:   'Public',
      email:      'publius@comcast.net',
      password:   'kN12oK9p!3',
      title:      'Hedge Wizard'
}

user = Echochamber::User.new(user_params)

user_id = client.create_user(user)
```

#### Setting up a new agreement from a URL 

```
url_file_params = {
      url:      'http://somedomain.com/contract.pdf',
      mimeType: 'application/pdf',
      name:     'contract.pdf'
}

file_info_params = {
     documentURL: Echochamber::UrlFileInfo.new(url_file_params) 
}

recipient_params = {
i    role: 'SIGNER', email: 'superguy@whatsit.com'
}

agreement_info_params = {
     fileInfos:       [ Echochamber::Fileinfo.new(file_info_params) ],
     recipients:      [ Echochamber::Recipient.new(recipient_params)],
     signatureFlow:   "SENDER_SIGNS_LAST",
     signatureType:   "ESIGN",
     name:            "Rumplestiltskin Contract"
}

agreement = Echochamber::Agreement.new(sender_id, sender_email, agreement_info) 

client.create_agreement(agreement)
```

## Documentation



