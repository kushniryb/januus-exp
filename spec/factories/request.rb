FactoryBot.define do
  factory :api_call, class: Hash do
    ContactCenter          { ('A'..'Z').to_a.shuffle[0..3].join }
    RequestNumber          { "09252012-#{Faker::Number.number(5)}" }
    ReferenceRequestNumber ''
    VersionNumber          { rand(9) }
    SequenceNumber         { (1..9).to_a.shuffle[0..3].join }
    RequestType            Ticket.request_types.values.sample
    RequestAction          'Restake'

    DateTimes do
      {
       'RequestTakenDateTime':   Faker::Time.between(6.month.ago, Date.today),
       'TransmissionDateTime':   '',
       'LegalDateTime':          Faker::Time.between(6.month.ago, Date.today),
       'ResponseDueDateTime':    Faker::Time.between(6.month.ago, Date.today),
       'RestakeDate':            Faker::Time.between(6.month.ago, Date.today),
       'ExpirationDate':         Faker::Time.between(6.month.ago, Date.today),
       'LPMeetingAcceptDueDate': '',
       'OverheadBeginDate':      '',
       'OverheadEndDate':        ''
      }
    end

    ServiceArea  do
      {
       'PrimaryServiceAreaCode':     { 'SACode': "ZZGL#{Faker::Number.number(3)}" },
       'AdditionalServiceAreaCodes': { 'SACode': [
                                                  "ZZL#{Faker::Number.number(2)}",
                                                  "ZZL#{Faker::Number.number(2)}",
                                                  "ZZL#{Faker::Number.number(2)}"
                                                 ] }
      }
    end

    Excavator do
      {
       'CompanyName':  Faker::Company.name,
       'Address':      Faker::Address.street_address,
       'City':         Faker::Address.city,
       'State':        Faker::Address.state_abbr,
       'Zip':          Faker::Address.zip,
       'Type':        'Excavator',
       'Contact':      {
         'Name':  Faker::DrWho.character,
         'Phone': Faker::PhoneNumber.phone_number,
         'Email': Faker::Internet.email
       },
       'FieldContact': {
         'Name':  Faker::Name.name,
         'Phone': Faker::PhoneNumber.phone_number,
         'Email': Faker::Internet.email
       },
       'CrewOnsite':   [true, false].sample
     }
    end

    ExcavationInfo do
      {
       'TypeOfWork':          Faker::Company.bs,
       'WorkDoneFor':         Faker::Company.name,
       'ProjectDuration':     "#{Faker::Number.number(5)} days",
       'ProjectStartDate':    Faker::Time.between(6.month.ago, Date.today),
       'Explosives':          ['Yes', 'No'].sample,
       'UndergroundOverhead': 'Underground',
       'HorizontalBoring':    Faker::HitchhikersGuideToTheGalaxy.marvin_quote,
       'Whitelined':          ['Yes', 'No'].sample,
       'LocateInstructions':  Faker::HitchhikersGuideToTheGalaxy.quote,
       'Remarks':             Faker::HitchhikersGuideToTheGalaxy.quote,
       'DigsiteInfo':         {
         'LookupBy':     'MANUAL',
         'LocationType': 'Multiple Address',
         'Subdivision':  '',
         'AddressInfo':  {
           'State':  Faker::Address.state_abbr,
           'County': Faker::Address.community,
           'Place':  Faker::Address.city,
           'Zip':    Faker::Address.zip,
           'Address': {
             'AddressNum': [
               Faker::Address.street_name,
               Faker::Address.street_name
             ]
           },
           'Street': {
             'Prefix': '',
             'Name':   Faker::Address.street_name,
             'Type':   Faker::Address.street_suffix,
             'Suffix': Faker::Address.street_suffix
           }
         },
         'NearStreet':  {
           'State':  Faker::Address.state_abbr,
           'County': Faker::Address.community,
           'Place':  Faker::Address.city,
           'Prefix': '',
           'Name':   '',
           'Type':   '',
           'Suffix': ''
         },
         'Intersection': {
           'ItoI': [{
               'State':  Faker::Address.state_abbr,
               'County': Faker::Address.community,
               'Place':  Faker::Address.city,
               'Prefix': '',
               'Name':   Faker::Address.city,
               'Type':   Faker::Address.street_suffix,
               'Suffix': Faker::Address.state_abbr
             },
             {
               'State':  Faker::Address.state_abbr,
               'County': Faker::Address.community,
               'Place':  Faker::Address.city,
               'Prefix': '',
               'Name':   Faker::Address.city,
               'Type':   Faker::Address.street_suffix,
               'Suffix': Faker::Address.state_abbr
             }
           ]
          },
         'WellKnownText': PolygonGenerator.random_polygon
        }
      }
    end

    initialize_with { attributes }
  end
end
