//
//  LiturgyData.swift
//  NativeMethodist
//
//  Created by Q002 on 07/02/2024.
//

import Foundation

let listurgyList:[LiturgyExpansionTile] = [
    LiturgyExpansionTile(
        id: 1,
        emoji: "1️⃣",
        title: "Call to Worship",
        liturgyContent: [
          LiturgyContent(
            id: 1,
            content: """
     An appropriate passage from the Bible will be read aloud from the Sanctuary by someone designated for the purpose, who shall also announce the processional hymn
    """)
        ]
      ),
      LiturgyExpansionTile(
        id: 2,
        emoji: "2️⃣",
        title: "Introit",
        liturgyContent: [
          LiturgyContent(
            id: 1,
            content: """
     The choir will sing introit after the procession. The one leading the service will welcome the congregation using one of the forms of greetings. \n\n Leader: Our help is in the name of God the Father\nPeople: Who made heaven and earth\nLeader: Our salvation is in his son, our Lord Jesus Christ.\nPeople: Who died for our sins and rose for our justification\nLeader: Our confidence isi in the Holy Spirit.\nPeople: Who enable us to become God's children\nLeader: Glory be to God: the Father, the Son, and the Holy Spirit.\nPeople: As it was in the beginning is now and ever shall be. Amen
    """)
        ]
      ),
    LiturgyExpansionTile(id: 3, emoji: "3️⃣", title: "Hymn"),
    LiturgyExpansionTile(id: 4, emoji: "4️⃣", title: "Prayer", liturgyContent: [
        LiturgyContent(
            id: 1,
            title: "Sentences and Responses", content: """
     Leader: The Lord be with you.\nPeople:and with your spirit.\n\n Leader: Let us pray: LORD, have mercy upon us.\nPeople: CHRIST, have mercy upon us; Lord,have mercy upon us.\n\n Leader: O LORD, show your mercy upon us. \nPeople: And grant us your salvation.\n\nLeader: O LORD, save our Head of State.\nPeople: And mercifully hear us when we call upon you.\n\nLeader: Endure your Ministers of the Gospel with righteousness.\n People
    """),
        LiturgyContent(
            id: 2,
            title:
                "Intercessory Prayers: The Peace of the nation, and People of the world",
            content: """
     Leader: Remember, O Lord, our nation Ghana and all who are in positions of authority and influence;remember in particular, the Head of State and all who assist him in running the affairs of this nation. Especially, at this time of our political history, we are humbly bring before throne of grace, all who are in government and in positions of authority, Cabinet Ministers, the Council of State, Ministers of State, the Parliament, the Judiciary, the Religious leaders, Grant them wisdom, honesty and compassion, that they may serve the people in accordance with your holy will; and for peace to prevail in our land. We pray also for the peoples compassion. Let them know justice, freedom and the peace which passes all understanding. Lord, hear our prayer.\nPeople: And let our cry come unto You.
    """),
        LiturgyContent(
            id: 3,
            title:
                "Intercessory Prayers: The Church in the world and especially this Church",
            content: """
    Leader: Remember, O Lord, your Church throughout the world, and especially this Church where we worship. Continually, enrich it with the gift of the Holy Spirit, that in faith and unity, we may constantly be renewed by the power of the Holy Spirit for witness and service. Give us your grace that we may worship you in spirit and in truth, always looking to the example of Christ, your Son and our Lord, who came as a servant. Lord, hear our prayer.\nPeople: And let our cry come unto you.
    """),
        LiturgyContent(
            id: 4,
            title:
                "Intercessory Prayers: For the sick, the afflicted, the employed and unemployed",
            content: """
    Leader: Remember in your mercy, O Lord, those of our fellowship who are in sickness, trouble, anxiety, grief or any kind of need. Relieve the oppressed, support the neglected and needy, and recall to yourself those who have erred and strayed from your way like lost sheep. Increase in us the spirit of compassion and care that we may relief. We remember, especially at this time, those in our Church and in our community, who are unemployed, all who are overworked, those whose work is not appreciated and those who work under strain and temptation. Strengthen their faith that they may be able to cope with the present conditions; and grant then patience of hope that they may be able to rely on you and strive for a better future. Lord, hear our prayer.\nPeople: And let our cry come unto you.
    """),
        LiturgyContent(
            id: 5,
            title: "Intercessory Prayers: For other situation of Concern",
            content: """
    Leader: O Lord; be our constant Guide, where we are faced with adversity, strengthen us that we may stand; where we are tempted to set aside our faith, increase our faith that we may rely on you alone; where the pleasures of this world threaten to blind us to the truth, let your Spirit strengthen our conviction to know that the truth in your Son Jesus Christ alone is that which can make us free. Pour in our hearts such love towards you that, loving you above all things, we may obtain your promises which exceed all that we may ask. Lord hear our prayer.\nPeople: And let our cry come unto you. After these intercessory prayers, the leader shall move the congregation to pray silently bringing their individual petitions before God.
    """),
        LiturgyContent(
            id: 6,
            title: "Intercessory Prayers: Individual Petitions", content: """
    Almighty God, Father of all mercies, we your unworthy servants do give you most humble and hearty thanks for all your goodness and loving-kindness to us and to all people; (particularly to those who desire now to offer you their praises and thanksgiving). We bless you for our creations. preservation, and all the blessings of his life; but above all for your inestimable love in the redemption of the world by our Lord Jesus Christ; for the means of grace, and for the hope of glory. And we beseech you, give us that due sense of all your mercies, that our hearts may be truly thankful, and that we amy show forth your praise, not only with our lips, but in our lives also, by giving up ourselves to your service to your service, and by walking before you in holiness and righteousness all our days; through Jesus Christ our Lord, to whom with you and the Holy Spirit be all honour and glory, world without end. Amen.
    """),
      ]),
    LiturgyExpansionTile(id: 5, emoji: "5️⃣", title: "Hymn"),
      LiturgyExpansionTile(
        id: 6,
        emoji: "6️⃣",
        title: "Ministry of the Word",
        liturgyContent: [
          LiturgyContent(
            id: 1,
            content: """
     The following prayer of illumination will be said by the leader before the reading of the Scripture. Lord, open our hearts and minds by the power of the Holy Spirit that as the Scriptures are read and your Word proclaimed, we may hear with joy what you say to us, Amen.\nNOTE! After the read ing of each of the two Bible Lessons, the reader shall conclude by saying: This is the Word of GOD And the people will respond: Thanks be to GOD.\n A brief moment of quiet meditation shall follow each reading.\nA brief moment of quiet meditation shall follow each reading\na) First Bible Reading\nb)Second Bible Reading\nTe Deum Laudamus(or any other Canticle)\nc) The Gospel REading (All standing)/nAfter reading the Gospel, the reader shall conclude by saying, This is the Gospel of our Lord Jesus Christ. And the congregation shall respond, Praise be to YOu, Christ our Lord!
    """)
        ]
      ),
      LiturgyExpansionTile(
        id: 7,
        emoji: "7️⃣",
        title: "Affirmation of Faith",
        liturgyContent: [
          LiturgyContent(
            id: 1,
            title: "AFFIRMATION I: THE APOSTLES\' CREED", content: """
     I Believe in God the Father Almighty ,
                        Maker of heaven and earth ,
                        And in Jesus Christ His only Son our Lord ,
                        Who was conceived by the Holy Ghost ,
                        Born of the Virgin Mary ,
                        Suffered under Pontius Pilate ,
                        Was crucified , dead and buried ,
                        Has descended into hell;
                        The third day He rose again from the dead ,He ascended into heaven ,
                        And sitteth on the right hand of God the Father Almighty;
                        From thence He shall come to judge the quick and the dead.
                        I believe in the Holy Ghost;
                        The holy Catholic Church ;
                        The Communion of Saints ;
                        The Forgiveness of sins '
                        The Resurrection of the body '
                        And the life everlasting.

                        Amen.
    """),
          LiturgyContent(
            id: 2,
            title: "AFFIRMATION II: THE NICENE CREED", content: """
                        I Believe in one God , the Father Almighty ,
                        Maker of heaven and earth, of all things visible and invisible: And in one Lord Jesus Christ , the only-begotten Son of God ,
                        Begotten of His Father before all worlds , God of God , Light of Light , Very God of very God , Begotten , not made , Being of one substance with the Father;
                        By whom all things were made ,Who for us men , and for our salvation came down from heaven ,
                        And was incarnate by the HOly Ghost of the Virgin Mary ,
                        And was made man , And was Crucified also for us under Pontius Pilate.
                        He suffered and was buried ,
                        And the third day He rose again according to the Scriptures , And ascended into heaven ,
                        And sitteth on the right hand of the Father.
                        And He shall come again with glory to judge both the quick and the dead ;
                        Whose kingdom shall have no end.
                        And I believe in the HOly Ghost ,
                        The Lord and Giver of life ,
                        Who proceedth form the Father and the Son ,
                        Who, with the Father and the Son together ,
                        is worshipped and glorified ,
                        Who spake tby the Prophets.
                        Ahd I believe one HOly , Catholic and Apostolic Church.
                        I acknowledge one Baptism for the remission of sins ,
                        And I look for the Resurrection of the dead ,
                        And the life of the world to come.
                        Who
                        Amen.
    """),
          LiturgyContent(
            id: 1,
              title: "AFFIRMATION III: THE HOLY APOSTOLIC FAITH", content: """
                        Leader: Where the Spirit the LORD is there in the One True Church, apostolic and universal whose holy faith let us now declare:

                        We beleive in God the Father, Infinite in wisdom, power and love, whose mercy is over all his works, and whose will is ever directed to his children's good. We believe in Jesus Christ Son of God and Son of Man, the gift of the Father's unfailing grace; the ground of our hope and the promise of our deliverance from sin and death. We believe in the Holy Spirit as the Divine Presence in our lives, whereby we are kept in perpetual remembrance of the truth of Christ, and find strength and help in time of need We believe that this faith should manifest itself in the service of love as set forth in the example of our blessed Lord, to the end that the Kingdom of God may come upon the earth.
                        Amen.
    """),
          LiturgyContent(
            id: 2,
            title: "AFFIRMATION IV: ROMANS 8:35, 37-39", content: """
                        Leader: Who shall separate us from the love of Christ? Shall tribulation or distress or persecution or famine, or nakedness or peril or sword?

                        Amen.
    """),
        ]
      ),
      LiturgyExpansionTile(
        id: 8,
        emoji: "8️⃣",
        title: "Invitation of Christian Discipleship", liturgyContent: nil
      ),
      LiturgyExpansionTile(
        id: 9,
        emoji: "9️⃣",
        title: "Announcement", liturgyContent: nil
      ),
      LiturgyExpansionTile(
        id: 10,
        emoji: "🔟",
        title: "Tithes and Offertory", liturgyContent: nil
      ),
      LiturgyExpansionTile(
        id: 11,
        emoji: "1️⃣1️⃣",
        title: "Hymn", liturgyContent: nil
      ),
      LiturgyExpansionTile(
        id: 12,
        emoji: "1️⃣2️⃣",
        title: "Benediction and Dismissal", liturgyContent: nil
      )
    ];

let liturgistContent:[LiturgyExpansionTile] = [
      LiturgyExpansionTile(
        emoji: "",
        title: "The minister says:",
        liturgyContent: [
          LiturgyContent(
            id: 1,
            content: """
     Beloved in the Lord, our Saviour Jesus Christ instituted the Holy Supper as a memorial of His death and to awaken and strengthen in us love of our brothers and sisters.\n
     As the branch can bear no fruit by itself, unless it abides in the vine, so we desire, through sharing in His Body broken for us and His Blood shed for us, to receive grace and new life from Him. For we remember His promise : "He who eats My flesh and drinks My blood, abides in Me and I in him. But the Lord can have fellowship with those who sincerely wish to be His disciples, who seek forgiveness of their sins through Him, and  who forgive one another; and who earnestly seek to nourish their faith by the use of the means of grace. Therefore let us individually examine ourselves and our service to God.\n
     Remember that GOD sees that which is hidden, he knows the secrets of our hearts and thoughts. It is not enough that we avoid the obvious and outward sins. We must rather let Him cleanse us from all corruption in thought, word and deed. Let us, therefore, kneel in silent prayer, humbling ourselves before the holy and all-knowing God. Lwt us ask ourselves earnestly:\n
     Do  I lead a life worthy of my Christian calling?
     Do I bring my body and soul under  God's discipline?
     Do I seek righteousness in God or do i seek my own honour?
     Do I fear men rather than God?
     Do I love my neighbor as myself?
     Do I repay evil with good as my Lord has taught me?
     Am I active in witness to Jesus Christ among my neighbours?
     Do I show the love of God to those in need and distress?
     Am I joyful in hope, patient in suffering, persevering in prayer and thankful in all things?\n

     If we say that we have no sin, we deceive ourselves and the truth is not in us. If we confess our sins, God is faithful and just, He will forgive our sins and cleanse us form all unrighteousness.\n
     Praise be to God who so loved the world that He gave His only begotten Son, that whoever believes in Him should not perish, but have eternal life. Praise be to the Son who gave His life for our redemption, Praise be to the Holy Spirit who guides our footsteps in the faith Amen.



    """)
        ]
      )
    ];

let liturgyContent:[LiturgyExpansionTile] = [
      LiturgyExpansionTile(
        emoji: "",
        title: "Invitation of Christian Discipleship",
        liturgyContent: [
          LiturgyContent(
            id: 1,
            content: """
    One of the following forms of greeting may be  used at the beginning of the service.\n
    Brothers and Sisters in Christ, we welcome you to all to this service. We pray that the Lord of the Church who is always present with his people will use this worship service to respond to your needs in a way that will benefit you both spiritually and physically. Once again, I welcome you and invite you to join in our worship service.\n
    Christian friends, this is another day the Lord has graciously given us. Lwt us rejoice as we gather in his presence at this worship service and offer him the praise and honour due to his name. In the name of Jesus Christ we welcome you heartily to join in our worship.\n
    How beautiful is it for brother and sister to fellowship together in Christ at a worship service such as this. On behalf of our resident minister and the leaders, I welcome you, may God bless our fellowship and send you all back for service in the world.\n
    The Lord is in his temple, let all the earth keep silent before him. Brothers and sisters, we invite you to participate in our worship service trusting  that you will not leave His presence without your needs having been taken care of by the Savour who so loved and gave his life for us. Yu are welcome to share in God's blessing at this service. \n
    They is none other than the house of God. At this place, we seek his face, ask for pardon for our sins and receive his power to go back into the world to live to his glory. We welcome all of you into our worship service; stay through and let us together worship the God of our fathers.\n
    They that wait upon the Lord shall renew their strength, they shall mount up with wings like eagles, they shall run and not weary, they will walk and never faint. Brothers and sisters, we welcome you all and invite you to join us in our worship service as we together wait upon him that is able to make us new and enables us to live victoriously. Welcome to your worship in the name of Jesus Christ our Lord.\n
    Brothers and Sisters, this is a place of worship and it is here that with a humble and obedient heart we receive assurance of our salvation. Those who come here in faith to worship have always testified to the goodness of God. Therefore, fear not, stand firm, only believe  and obey and you will see the deliverance that the Lord will bring to you today,  you are welcome.\n
    Brothers and sisters, God is spirit and he demands that those who worship gim do so in spirit and in truth. Welcome to oyr worship service. It is our prayer that through our worship, your spiritual and material needs shall be met by God. One again, in the nome of Jesus, welcome.
    """)
        ]
      ),
      LiturgyExpansionTile(
        emoji: "",
        title: "PRAYERS FOR DEDICATION OF OFFERINGS",
        liturgyContent: [
          LiturgyContent(
            id: 1,
            content: """
    Accept oh Lord these offerings, which your people bring to you and grant that the work to which they are devoted, may prosper under your guidance, to the glory of your name; through Jesus Christ our Lord. Amen\n
    Almighty God, who loving hands has given us all that we posses; grant us grace that we may honour you with our substance, and remembering the account which we must one day give, be faithful stewards of your bounty; through Jesus Christ or Lord. Amen\n
    Lord Jesus, who for our sake became poor that by your poverty we might become rich: grant to your people so to give off their substance as to acknowledge that they belong wholly to you; for your own sake. Amen.\n
    Heavenly Father , giver of all good things, who have taught us that it is more blessed to give than to receive. We dedicate our offerings to the service of your church, humbly beseeching you that all our gifts and energies may be consecrated to the extension of your kingdom on earth; through Jesus Christ our Lord.Amen\n
    Almighty God, the source of all our comfort and joy; receive us and these gifts as we dedicate them and ourselves a new to you. Consecrate for us the experience and resolve for his hour, and lead us in the way of true understanding and fruitful service; through Jesus Christ our Lord. Amen
    """)
        ]
      ),
      LiturgyExpansionTile(
          emoji: "",
          title: "FORMS OF BENEDICTION",
          liturgyContent: [
            LiturgyContent(
                id: 1,
                content: """
    Dismiss us now, O Lord, with your blessing and accompany us ever with your grace that we may henceforth live in peace, love and holiness. Amen.\n
    Go forth in peace. The grace of the Lord Jesus Christ and the love of God and communion of the Holy Spirit be with you all. Amen. (2 Corinthians 13:14)\n
    The Lord bless you and keep; the Lord make his face to shine upon you and be gracious to you; the Lord lift up his countenance upon you and give you peace. Amen. (Numbers 6:24-26)\n
    And now may the blessing of God Almighty, Father, Son and the Holy Spirit, be among you and abide with you now and evermore. Amen\n
    Now may the God of peace who brought again from the dead our Lord Jesus, the great shepherd of the sheep, by the blood of the eternal covenant, equip you with everything good that may do his will, working in you that which is pleasing in his sight, through Jesus which is pleasing in his sight, through Jesus Christ to whom be glory for ever and ever. Amen (Hebrew 13: 20-21)\n
    Go in peace with the blessing of God: and the peace of God which passes all understanding, keep your hearts and minds in the knowledge and love of God, and of his son Jesus Christ our Lord: and the blessing of God almighty, the Father, the Son and the Holy Spirit, be upon you and remain with you always. Amen\n
    May the God of hope fill you with all joy and peace in believing so that you may abound in hope by the power of the Holy Spirit. Amen (Romans 15:1-3)\n
    Go forth into the world in peace; be of good courage; hold fast that which is good; render to no man evil for evil; strengthen the faint-hearted; support the weak help the afflicted; honour all men; love and serve the Lord; rejoicing in the power of the Holy Spirit. And the blessing of God Almighty, Father , Son and Holy spirit, be upon you and remain with you always.
    """)
          ])

]
