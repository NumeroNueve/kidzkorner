import Foundation

struct StoryInputs: Codable {
    var heroName: String = ""
    var animal: String = ""
    var place: String = ""
    var food: String = ""
    var color: String = ""
    var sillySound: String = ""
}

struct StoryTemplate {
    let title: String
    let build: (StoryInputs) -> String

    static let all: [StoryTemplate] = [
        StoryTemplate(title: "The Big Adventure") { inputs in
            """
            Once upon a time, in a cozy little house at the end of a rainbow-colored street, \
            there lived a brave kid named \(inputs.heroName). \(inputs.heroName) had the most amazing \
            best friend in the whole wide world — a \(inputs.color) \(inputs.animal) who loved to eat \
            \(inputs.food) for breakfast, lunch, dinner, and even as a midnight snack!

            Every morning, the \(inputs.animal) would wake up \(inputs.heroName) by licking their face \
            and saying "\(inputs.sillySound)!" That was the \(inputs.animal)'s way of saying good morning.

            One sunny morning, \(inputs.heroName) looked out the window and saw something sparkling far away. \
            "What is that?" asked \(inputs.heroName). The \(inputs.animal) wagged its tail and pointed \
            toward \(inputs.place). "Let's go find out!" said \(inputs.heroName).

            They packed a big \(inputs.color) backpack full of \(inputs.food). \(inputs.heroName) put on \
            their favorite \(inputs.color) boots, and the \(inputs.animal) put on a tiny matching hat. \
            They looked at each other and laughed. Off they went!

            First, they walked through the Tickle Grass Meadow. The grass was so tall it tickled their \
            bellies! The \(inputs.animal) kept sneezing — "\(inputs.sillySound)! \(inputs.sillySound)!" — \
            and every time it sneezed, butterflies flew out of the grass in every color of the rainbow.

            "Bless you!" giggled \(inputs.heroName). The \(inputs.animal) sneezed one more time, and this time \
            a butterfly landed right on its nose. They both laughed so hard they fell down in the soft grass.

            After catching their breath, they crossed the Wobbly Bridge. The bridge went back and forth, \
            back and forth. \(inputs.heroName) held onto the ropes tight. The \(inputs.animal) wasn't scared \
            at all — it danced across like it was the easiest thing in the world! "Show off!" said \(inputs.heroName), \
            but they were smiling.

            On the other side of the bridge, they met a friendly old owl sitting in a tree. "Hoo hoo! \
            Are you heading to \(inputs.place)?" asked the owl. "Yes we are!" said \(inputs.heroName). \
            "Well then," said the owl, "you'll need to go through the Singing Cave. But don't worry — \
            just sing a song and the cave will light up for you."

            \(inputs.heroName) and the \(inputs.animal) found the Singing Cave. It was very dark inside. \
            "I'm a little scared," whispered \(inputs.heroName). The \(inputs.animal) nuzzled close and \
            said "\(inputs.sillySound)" very softly, as if to say "I'm right here."

            \(inputs.heroName) started to sing: "We're going on an adventure, my \(inputs.animal) and me! \
            We're going to \(inputs.place), just you wait and see!" And just like the owl said, the \
            whole cave lit up with \(inputs.color) crystals glowing on every wall! It was the most beautiful \
            thing they had ever seen.

            They walked through the glowing cave and came out the other side. And there it was — \(inputs.place)! \
            It was even more amazing than they had imagined. And right in the middle was the sparkling thing \
            they had seen from the window — a giant \(inputs.color) slide! It was the biggest slide in the \
            whole entire world!

            \(inputs.heroName) climbed to the very tip-top. "Here I gooooo!" And down they slid, faster and \
            faster, yelling "\(inputs.sillySound)!" the whole way down. They landed in a big pile of soft leaves. \
            The \(inputs.animal) slid down right after, holding a piece of \(inputs.food) in its mouth the whole time.

            They slid down that slide ten more times. Then twenty more times! Each time was more fun than the last. \
            Sometimes they went down together, sometimes backwards, and once the \(inputs.animal) went down \
            spinning in circles!

            When they finally got tired of sliding, they sat under a big shady tree and shared their \(inputs.food). \
            "This is the best day ever," said \(inputs.heroName). The \(inputs.animal) nodded and said \
            "\(inputs.sillySound)!" which definitely meant "I agree!"

            As the sun started to paint the sky in shades of orange and pink, \(inputs.heroName) and the \
            \(inputs.animal) started walking home. They went back through the glowing cave, singing their song again. \
            They crossed the Wobbly Bridge, and this time \(inputs.heroName) danced across just like the \(inputs.animal). \
            They ran through the Tickle Grass Meadow one more time, laughing all the way.

            When they got home, \(inputs.heroName) gave the \(inputs.animal) a big hug. "Same time tomorrow?" \
            asked \(inputs.heroName). The \(inputs.animal) wagged its tail and said "\(inputs.sillySound)!" \
            And that meant yes.

            \(inputs.heroName) climbed into bed, pulled up the \(inputs.color) blanket, and the \(inputs.animal) \
            curled up right beside them. As they drifted off to sleep, \(inputs.heroName) whispered, \
            "That was the best adventure ever." And the \(inputs.animal) quietly whispered back, \
            "\(inputs.sillySound)."

            The end.
            """
        },

        StoryTemplate(title: "The Silly Race") { inputs in
            """
            It was the most exciting day of the whole year. \(inputs.heroName) could barely sleep \
            the night before because today was the Great Silly Race at \(inputs.place)! The Great \
            Silly Race wasn't like a normal race. Oh no. In this race, everything was silly!

            \(inputs.heroName) jumped out of bed, put on a \(inputs.color) racing helmet, and ran to the kitchen. \
            "I need a big breakfast for the big race!" said \(inputs.heroName). So they ate a giant plate \
            of \(inputs.food). Then another plate. Then one more, just to be safe.

            At \(inputs.place), the starting line was already packed with racers. Every racer got to pick \
            an animal to ride. There was a purple penguin, an orange elephant, a polka-dot giraffe, \
            a sparkly unicorn, and a very sleepy sloth. \(inputs.heroName) looked at all of them, but there \
            was only one choice — a speedy \(inputs.color) \(inputs.animal)!

            "Hey there, buddy," said \(inputs.heroName), giving the \(inputs.animal) a pat. The \(inputs.animal) \
            said "\(inputs.sillySound)!" and did a little spin. They were ready.

            The announcer, a tall flamingo wearing a top hat, stepped up to the microphone. \
            "Welcome, everyone, to the Great Silly Race! Remember — this is a SILLY race. \
            The silliest racer wins!" The crowd went wild!

            "On your marks! Get set! \(inputs.sillySound)!" yelled the flamingo, and they were off!

            The first obstacle was the Spaghetti Swamp. Long, slippery noodles everywhere! The penguin \
            got all tangled up and did three backflips. The elephant tried to tiptoe through but slipped \
            and sat right down in the noodles. \(inputs.heroName) and the \(inputs.animal) zigzagged through \
            like champions, the \(inputs.animal) leaping over the biggest noodle piles.

            Next came the Bubble Mountain. Giant bubbles floated everywhere, and if one popped on you, \
            it covered you in \(inputs.color) glitter! Pop! Pop! Pop! \(inputs.heroName) was completely \
            covered in glitter now. The \(inputs.animal) shook itself off and glitter flew everywhere. \
            "\(inputs.sillySound)!" laughed the \(inputs.animal).

            Then they reached the Backwards Bridge. The rule was you had to cross it walking backwards! \
            \(inputs.heroName) walked backwards very carefully. The \(inputs.animal) tried to walk backwards too, \
            but it kept looking over its shoulder and bumping into things. The giraffe's long neck kept \
            getting confused about which way was backwards!

            After the bridge came the \(inputs.food) Fountain. A giant fountain was shooting \(inputs.food) \
            into the air! To get past it, the racers had to catch a piece in their mouth. \(inputs.heroName) \
            opened wide and caught a piece on the first try! The \(inputs.animal) caught three pieces. \
            Okay, maybe four. Okay, the \(inputs.animal) just stood there eating for a while.

            "Come on, buddy!" laughed \(inputs.heroName). The \(inputs.animal) grabbed one more piece of \
            \(inputs.food) and they kept going.

            The second-to-last obstacle was the Silly Dance Floor. You couldn't run across it — you had \
            to dance! Music played and lights flashed in every color. \(inputs.heroName) did the robot. \
            Then the chicken dance. Then a move they made up called the \(inputs.animal) Shuffle. The crowd \
            loved it! Everyone was clapping and shouting "\(inputs.sillySound)!"

            The \(inputs.animal) did the silliest dance of all — it spun in circles, wiggled its bottom, \
            and moonwalked across the finish zone. Even the judges were laughing!

            Finally, the last stretch — a straight run to the finish line. But wait! There was a giant \
            \(inputs.color) river of pudding blocking the road! Every racer stopped and stared.

            Not \(inputs.heroName). "Let's go!" they shouted. The \(inputs.animal) took a running start and \
            leaped right into the pudding. SPLASH! \(inputs.food) and pudding flew everywhere! They splashed \
            and splooshed their way through. The \(inputs.animal) was swimming! \(inputs.heroName) was laughing!

            They burst out the other side, covered head to toe in pudding, and crossed the finish line. \
            The crowd at \(inputs.place) went absolutely bonkers!

            The flamingo announcer waddled over. "The winner of the Great Silly Race is — \(inputs.heroName) \
            and the \(inputs.color) \(inputs.animal)! You were the silliest of them all!"

            Everyone got a trophy shaped like a giant piece of \(inputs.food), and the \(inputs.animal) \
            did its happy dance one more time. \(inputs.heroName) held up the trophy high above their head \
            and shouted "\(inputs.sillySound)!" so loud that everyone at \(inputs.place) shouted it right back.

            On the way home, still covered in pudding and glitter, \(inputs.heroName) looked at the \(inputs.animal) \
            and said, "Same time next year?" The \(inputs.animal) wagged its tail, burped up a little piece \
            of \(inputs.food), and said "\(inputs.sillySound)!" And that definitely meant yes.

            The end.
            """
        },

        StoryTemplate(title: "The Secret Treasure") { inputs in
            """
            It all started on a rainy afternoon. \(inputs.heroName) was cleaning under the bed — which \
            almost never happened — when something crinkled under the mattress. \(inputs.heroName) pulled \
            it out and gasped. It was a \(inputs.color) map! A real, actual treasure map!

            The map was old and crinkly, with little drawings all over it. There was a dotted line \
            that wound through forests and mountains and rivers, and at the very end was a big red X \
            at \(inputs.place). Under the X, someone had written: "The greatest treasure of all."

            "Are you seeing this?" said \(inputs.heroName) to the trusty \(inputs.animal), who was napping \
            on the pillow. The \(inputs.animal) opened one eye, saw the map, and jumped up immediately. \
            "\(inputs.sillySound)!" it said, which clearly meant "Let's go right now!"

            They packed supplies: a flashlight, a compass, a rope, and of course a big bag of \(inputs.food). \
            \(inputs.heroName) put on a \(inputs.color) explorer hat, and they headed out the door into the rain.

            The first part of the map led through the Whispering Woods. The trees were so tall their tops \
            disappeared into the clouds. Every time the wind blew, the leaves whispered secrets. \
            "What are they saying?" asked \(inputs.heroName). The \(inputs.animal) listened carefully, \
            then whispered "\(inputs.sillySound)!" \(inputs.heroName) laughed. "I don't think that's what they said."

            Deep in the woods, they came across a fork in the path. The map showed they should go left, \
            past the \(inputs.color) mushrooms. Sure enough, there they were — mushrooms as tall as \
            \(inputs.heroName), glowing in beautiful shades of \(inputs.color). Some of them had tiny doors. \
            "I wonder who lives in there," whispered \(inputs.heroName). A tiny voice from inside squeaked \
            "\(inputs.sillySound)!" and they both jumped!

            A little mouse popped out wearing a tiny hat. "Are you looking for the treasure?" asked the mouse. \
            "Yes!" said \(inputs.heroName). "Then beware the Riddle Bridge," said the mouse. "You must answer \
            a riddle to cross." The mouse tipped its tiny hat and disappeared back inside the mushroom.

            They followed the map to the Riddle Bridge. It was a beautiful old bridge over a rushing river, \
            and sitting in the middle was a very serious-looking frog. "None shall pass," said the frog, \
            "unless you answer my riddle."

            "Okay," said \(inputs.heroName) bravely. "Ask your riddle."

            The frog cleared its throat. "What has four legs in the morning, two legs at noon, and smells \
            like \(inputs.food) in the evening?"

            \(inputs.heroName) thought very hard. The \(inputs.animal) thought hard too. Then the \(inputs.animal) \
            sniffed the bag of \(inputs.food) they were carrying and looked at \(inputs.heroName) with big eyes.

            "Is it... my \(inputs.animal) after dinner time?" guessed \(inputs.heroName).

            The frog blinked. Then it burst out laughing so hard it almost fell off the bridge. "That's \
            the funniest answer I've ever heard! I'll allow it. You may pass!" And the frog hopped aside, \
            still giggling.

            Across the bridge, the map led them up Bumble Mountain. It wasn't too tall, but it was very bumpy. \
            Every few steps, \(inputs.heroName) would trip and go "Whoops!" and every few steps the \(inputs.animal) \
            would trip and go "\(inputs.sillySound)!" By the time they reached the top, they were both giggling \
            so much they could barely walk straight.

            From the top of the mountain, they could see \(inputs.place) spread out below them. It looked \
            magical in the afternoon light. "There it is!" said \(inputs.heroName). "That's where the treasure is!"

            They ran down the mountain, through a field of \(inputs.color) wildflowers, and arrived at \(inputs.place). \
            Right in the middle, just like the map showed, was a big X made of stones on the ground.

            "This is it!" said \(inputs.heroName). The \(inputs.animal) started digging with its paws. \
            Dirt flew left. Dirt flew right. Dirt flew up in the air and landed on \(inputs.heroName)'s head. \
            "Hey!" laughed \(inputs.heroName), shaking off the dirt.

            CLUNK! The \(inputs.animal)'s paw hit something hard. They both dug faster now. Bit by bit, \
            a treasure chest appeared. It was made of dark wood with \(inputs.color) gems on the lid.

            \(inputs.heroName) took a deep breath and opened it. Inside, the chest was filled to the brim! \
            There was a mountain of \(inputs.food) — enough to last a whole year! There were shiny \(inputs.color) \
            gems and gold coins. And right on top was a tiny \(inputs.color) crown, just the perfect size \
            for the \(inputs.animal).

            \(inputs.heroName) placed the crown on the \(inputs.animal)'s head. The \(inputs.animal) looked \
            so proud and noble. Then it immediately shook its head and the crown fell over one eye, making it \
            look completely ridiculous. "\(inputs.sillySound)! \(inputs.sillySound)!" it said, doing a funny \
            dance with the crooked crown.

            \(inputs.heroName) laughed so hard tears came out. They sat beside the treasure chest, shared the \
            \(inputs.food) with each other, and watched the sunset paint the sky over \(inputs.place).

            "You know what the map said?" said \(inputs.heroName). "It said this was 'the greatest treasure of all.' \
            I don't think it meant the gold and the \(inputs.food). I think it meant the adventure. And having \
            you with me." The \(inputs.animal) leaned its head against \(inputs.heroName) and said \
            "\(inputs.sillySound)" very, very softly.

            They loaded the treasure into the backpack, put the crooked crown back on the \(inputs.animal), \
            and walked home under the stars. \(inputs.heroName) fell asleep that night with the map under \
            the pillow, already dreaming about the next adventure.

            The end.
            """
        },

        StoryTemplate(title: "The Dream Cloud") { inputs in
            """
            It was bedtime, and \(inputs.heroName) was all tucked in under a cozy \(inputs.color) blanket. \
            The room was dark and quiet. The moon shone through the window, making silver squares on the floor. \
            \(inputs.heroName) closed their eyes and started to drift off to sleep.

            And then something magical happened.

            A soft, fluffy \(inputs.color) cloud floated right through the window! It bobbed up and down \
            gently, like it was breathing. It glowed with a warm light, and it smelled like \(inputs.food).

            "Psst!" said the cloud. "Psst! \(inputs.heroName)! Wake up!"

            \(inputs.heroName) opened their eyes wide. "Did you just... talk?"

            "Of course I talked!" said the cloud. "I'm a Dream Cloud. I take kids on the most amazing \
            adventures while they sleep. Want to come?"

            \(inputs.heroName) didn't have to be asked twice. They jumped out of bed and landed right \
            on top of the cloud. It was the softest thing they had ever felt — softer than pillows, softer \
            than marshmallows, softer than a hundred fluffy kittens.

            "Hold on!" said the cloud, and — WHOOOOSH! — they flew right out the window and up, up, up \
            into the starry sky. \(inputs.heroName) looked down and saw the whole town getting smaller and smaller.

            "Where are we going?" asked \(inputs.heroName). "You'll see!" said the cloud with a twinkly laugh.

            As they flew higher, they passed through a field of floating bubbles. Each bubble had a tiny \
            dream inside it. \(inputs.heroName) could see dreams about birthday parties and roller coasters \
            and swimming pools. "Those are other kids' dreams," explained the cloud. "Everyone is dreaming \
            right now."

            Then \(inputs.heroName) spotted something on the cloud. A friendly \(inputs.animal) was already \
            sitting there, wearing pajamas and munching on \(inputs.food)! "Oh hello!" said the \(inputs.animal). \
            Well, it didn't exactly say that. It said "\(inputs.sillySound)!" But \(inputs.heroName) understood.

            "Hey buddy!" said \(inputs.heroName), giving the \(inputs.animal) a hug. "I didn't know you \
            could come to dreams too!" The \(inputs.animal) offered \(inputs.heroName) some \(inputs.food) \
            and they both snacked as the cloud flew on.

            Soon they flew over \(inputs.place), and everything below looked tiny like toys. \
            \(inputs.heroName) could see tiny trees and tiny buildings and tiny cars driving around. \
            "It's like a dollhouse!" said \(inputs.heroName).

            The \(inputs.animal) pointed its paw down at something amazing — a \(inputs.color) castle made \
            entirely of \(inputs.food)! The walls were \(inputs.food), the towers were \(inputs.food), even \
            the flag on top was made of \(inputs.food)!

            "Let's go there!" said \(inputs.heroName). The cloud floated down gently and they landed right \
            on the front doorstep of the castle.

            The door opened by itself with a loud "\(inputs.sillySound)!" Inside, the hallway was lit by \
            floating candles that changed color — \(inputs.color), then gold, then silver, then back to \(inputs.color). \
            The floor was made of something bouncy, like a trampoline!

            \(inputs.heroName) took a step and — BOING! — bounced three feet in the air! The \(inputs.animal) \
            bounced even higher! "\(inputs.sillySound)!" it yelled with delight.

            They bounced from room to room, each one more wonderful than the last. The first room was full \
            of musical instruments that played themselves. Drums went boom boom boom, guitars went twang twang twang, \
            and a tiny piano played a funny song that made the \(inputs.animal) dance.

            The second room was a giant ball pit, but all the balls were different colors of \(inputs.color) \
            and they glowed in the dark! \(inputs.heroName) dove in headfirst. The \(inputs.animal) cannonballed \
            right after. They swam through the glowing balls, throwing them at each other and laughing.

            The third room was the kitchen, and everything was made of \(inputs.food). \(inputs.heroName) \
            broke off a piece of the table and took a bite. "Yep, that's real \(inputs.food)!" The \(inputs.animal) \
            was already eating a chair leg. In a dream, nobody minds if you eat the furniture.

            They bounced up a long spiraling staircase to the very top tower of the castle. From up there, \
            they could see the entire dream world. There were cotton candy mountains, chocolate rivers, \
            and a forest where all the trees were upside down. In the distance, a train made of rainbows \
            chugged across the sky.

            "This is the best dream ever," said \(inputs.heroName). The \(inputs.animal) nodded, its mouth \
            still full of \(inputs.food).

            They played in the castle for what felt like hours. They had a bouncing contest — the \(inputs.animal) \
            won. They had an eating contest — also the \(inputs.animal). They had a silly sound contest, and \
            the \(inputs.animal) yelled "\(inputs.sillySound)!" so loud it echoed through every room in the castle.

            Then \(inputs.heroName) noticed the sky outside was starting to change. The stars were fading, \
            and the edges of the dream were getting fuzzy. "I think it's almost morning," said \(inputs.heroName) sadly.

            The \(inputs.color) cloud appeared at the tower window. "Time to go home, sleepyhead," it said gently.

            \(inputs.heroName) and the \(inputs.animal) climbed back onto the cloud. As they flew up and away \
            from the castle, \(inputs.heroName) looked back and waved. The floating candles in the windows \
            blinked like they were waving back.

            The cloud flew them home, slow and gentle. The \(inputs.animal) fell asleep on the cloud, \
            snoring softly. \(inputs.heroName) felt their eyes getting heavy too.

            The cloud floated back through the bedroom window and gently set \(inputs.heroName) down in bed. \
            It pulled the \(inputs.color) blanket up to their chin. The \(inputs.animal) curled up at the \
            foot of the bed, still wearing its pajamas.

            "Will you come back tomorrow night?" murmured \(inputs.heroName).

            "Every night," whispered the cloud. "Whenever you close your eyes, I'll be here. And the \
            \(inputs.animal) will be here too."

            \(inputs.heroName) smiled, already half asleep. Outside the window, the first rays of sunshine \
            peeked over the horizon. And if you listened very, very carefully, you could hear the quietest \
            little "\(inputs.sillySound)" as the dream cloud drifted away.

            The end.
            """
        },

        StoryTemplate(title: "The Birthday Surprise") { inputs in
            """
            \(inputs.heroName) woke up and something felt different. The air smelled like \(inputs.food) \
            and there were \(inputs.color) streamers hanging from the ceiling. "Wait a minute..." said \
            \(inputs.heroName). Then it hit them. "It's my birthday!"

            The \(inputs.animal) burst through the door wearing a party hat and carrying a \(inputs.color) balloon. \
            "\(inputs.sillySound)!" it shouted, which was its way of saying "Happy Birthday!"

            "Thank you, buddy!" said \(inputs.heroName), giving the \(inputs.animal) a big hug. "But where \
            is everyone?" The house was quiet. Too quiet. The \(inputs.animal) grinned a sneaky grin and \
            grabbed \(inputs.heroName)'s hand. "Where are we going?" asked \(inputs.heroName). The \(inputs.animal) \
            just said "\(inputs.sillySound)!" and pulled them toward the door.

            They walked down the street, and everything looked normal at first. But then \(inputs.heroName) \
            noticed the mailbox had a \(inputs.color) bow on it. And the tree had \(inputs.color) ribbons. \
            And the fire hydrant was wearing a tiny party hat!

            "Something is going on," said \(inputs.heroName) with a big smile. The \(inputs.animal) pretended \
            not to know anything, but its tail was wagging like crazy.

            They turned the corner and arrived at \(inputs.place). The gate was decorated with balloons \
            of every color, but mostly \(inputs.color) because that was \(inputs.heroName)'s favorite. \
            A sign made of \(inputs.food) spelled out "HAPPY BIRTHDAY!"

            \(inputs.heroName) pushed open the gate and — "SURPRISE!" A huge crowd jumped out! There were \
            friends and family and neighbors and even the mail carrier. Everyone was wearing \(inputs.color) \
            party hats. Confetti rained down from everywhere.

            "You knew about this?" \(inputs.heroName) asked the \(inputs.animal). The \(inputs.animal) did \
            its best innocent face, then burst out with "\(inputs.sillySound)!" and everyone laughed.

            The party was incredible. First there was a game of musical chairs, except instead of chairs, \
            everyone sat on giant \(inputs.color) cushions. The music played and everyone danced around. \
            When the music stopped, the \(inputs.animal) dove for a cushion and landed on three of them \
            at once. "\(inputs.sillySound)!" it said proudly. Everyone agreed that counted.

            Next was the piñata. But this wasn't a normal piñata — it was shaped like a giant piece of \
            \(inputs.food) and it was filled with candy AND more \(inputs.food)! \(inputs.heroName) put on \
            a blindfold and swung the bat. WHACK! Nothing. WHACK! A little crack. WHACK! The piñata exploded \
            and \(inputs.food) and candy rained down everywhere! The \(inputs.animal) caught more than anyone else, \
            stuffing its cheeks like a chipmunk.

            Then came the obstacle course. There was a tunnel to crawl through, a wall to climb over, \
            monkey bars to swing across, and a big \(inputs.color) slip-and-slide at the end. \(inputs.heroName) \
            raced through it in record time. The \(inputs.animal) got stuck in the tunnel because it had \
            eaten too much \(inputs.food). Everyone had to pull it out by its back legs. "\(inputs.sillySound)!" \
            it said sheepishly.

            When it was time for cake, the lights dimmed. Everyone started singing "Happy Birthday." \
            The \(inputs.animal) sang too, except its version was just "\(inputs.sillySound), \(inputs.sillySound), \
            \(inputs.sillySound), \(inputs.sillySound)!" to the same tune.

            The cake was the most beautiful cake \(inputs.heroName) had ever seen. It was \(inputs.color) \
            with three layers, and on top was a little sugar version of \(inputs.heroName) and the \(inputs.animal) \
            having an adventure together. "It's perfect," whispered \(inputs.heroName).

            \(inputs.heroName) closed their eyes to make a wish. They thought very hard. Then they blew \
            out all the candles in one big breath. Everyone cheered!

            "What did you wish for?" asked a friend. \(inputs.heroName) looked at the \(inputs.animal), \
            looked at all the friends gathered at \(inputs.place), looked at the decorations and the cake \
            and the confetti still in everyone's hair. "I wished for everything to stay just like this," \
            said \(inputs.heroName). "Because right now, everything is perfect."

            The \(inputs.animal) climbed into \(inputs.heroName)'s lap and nuzzled close. \
            "\(inputs.sillySound)," it said softly. And that meant "I love you. Happy Birthday."

            The end.
            """
        },

        StoryTemplate(title: "The Underwater Kingdom") { inputs in
            """
            \(inputs.heroName) was walking along the beach near \(inputs.place) when they spotted something \
            shimmering in the shallow water. It was a \(inputs.color) seashell, the prettiest one they had \
            ever seen. When \(inputs.heroName) picked it up and held it to their ear, instead of hearing the \
            ocean, they heard a tiny voice say, "Would you like to visit the Underwater Kingdom?"

            "Yes please!" said \(inputs.heroName) without even thinking. The \(inputs.animal) barked \
            "\(inputs.sillySound)!" which meant "Me too!"

            The seashell glowed bright \(inputs.color), and suddenly a giant bubble appeared around \
            \(inputs.heroName) and the \(inputs.animal). It was warm and dry inside, and they could breathe \
            perfectly. The bubble lifted off the sand, floated over the waves, and then — SPLOOSH! — \
            dove straight under the water.

            Down, down, down they went. Fish swam by the bubble, pressing their faces against it curiously. \
            A friendly dolphin did a flip and waved a fin. The \(inputs.animal) pressed its nose against the \
            bubble wall and said "\(inputs.sillySound)!" at a passing jellyfish, which glowed \(inputs.color) \
            in response.

            The deeper they went, the more magical it became. There were coral gardens in every color \
            imaginable. Sea turtles floated by carrying tiny lanterns. A school of fish arranged themselves \
            into the shape of an arrow, pointing the way forward.

            And then they saw it — the Underwater Kingdom. A beautiful city made of pearls and coral and \
            sea glass, all glowing in shades of \(inputs.color). Towers spiraled up toward the surface, \
            and bridges made of kelp connected building to building. Mermaids and mermen swam between the \
            towers, and an octopus was directing traffic at a busy intersection.

            The bubble floated through the main gate, where a seahorse guard bowed and said, "Welcome, \
            surface friends! The Queen has been expecting you."

            "The Queen?" said \(inputs.heroName), eyes wide. The \(inputs.animal) tried to look dignified \
            but its party hat from this morning was still on its head.

            They floated into the throne room. The Queen was a beautiful mermaid with a \(inputs.color) tail \
            and a crown made of starfish. "Welcome to our kingdom!" she said. "We've prepared a feast in your honor."

            The banquet table was incredible. Everything was made from the sea, but it looked and smelled \
            like... \(inputs.food)! "\(inputs.food) grows on the ocean floor here," explained the Queen. \
            "It's our most popular dish." The \(inputs.animal) didn't need to be told twice — it dove face-first \
            into a plate and came up with \(inputs.food) all over its whiskers. "\(inputs.sillySound)!" it said \
            happily.

            After the feast, the Queen gave them a tour. They visited the Bubble Playground, where kids \
            bounced from bubble to bubble like trampolines. \(inputs.heroName) bounced so high they almost \
            left the water! The \(inputs.animal) popped three bubbles in a row and did a somersault.

            They visited the Glow Garden, where everything was bioluminescent. Flowers lit up when you \
            touched them. The \(inputs.animal) rolled through a patch of glow-moss and came out looking \
            like a \(inputs.color) disco ball. "\(inputs.sillySound)!" it said, spinning around to show off.

            They even visited the Whale Library, where stories were told by whales who sang them in \
            deep, rumbling voices. The \(inputs.animal) fell asleep during a story about a brave little \
            clam, snoring tiny bubbles.

            "I wish we could stay forever," said \(inputs.heroName). The Queen smiled kindly. "You can \
            visit anytime. Just hold the \(inputs.color) seashell and ask."

            She gave \(inputs.heroName) a necklace with a tiny pearl that glowed \(inputs.color). "So you \
            remember us," she said. The \(inputs.animal) got a tiny coral crown for its collection.

            The bubble carried them back up, up, up through the water, past the fish and the jellyfish \
            and the friendly dolphin who waved goodbye. They popped out of the ocean and landed softly on \
            the beach.

            \(inputs.heroName) looked at the \(inputs.color) seashell in one hand and the glowing pearl \
            necklace around their neck. The \(inputs.animal) shook water off its fur and said "\(inputs.sillySound)!" \
            which meant "That was the best day ever."

            As they walked home along the beach, \(inputs.heroName) could swear they heard the Queen's voice \
            on the wind: "See you next time." And \(inputs.heroName) smiled, because they knew there would \
            definitely be a next time.

            The end.
            """
        },

        StoryTemplate(title: "The Magical Kitchen") { inputs in
            """
            It was a rainy Saturday, and \(inputs.heroName) was bored. "There's nothing to do!" said \
            \(inputs.heroName), flopping on the couch. The \(inputs.animal) was bored too — it had already \
            chewed every toy and napped in every sunny spot (which today was zero sunny spots, because of the rain).

            "Let's make something in the kitchen," said \(inputs.heroName). The \(inputs.animal) perked up \
            at the word "kitchen" and raced there so fast its paws slid on the floor. "\(inputs.sillySound)!" \
            it yelped as it crashed into a cabinet. It was fine.

            \(inputs.heroName) opened the pantry to find ingredients. But something was different today. \
            The back of the pantry was glowing \(inputs.color). \(inputs.heroName) pushed aside the cereal \
            boxes and the cans of soup and found... a door. A tiny \(inputs.color) door that definitely \
            had not been there yesterday.

            "Should we open it?" whispered \(inputs.heroName). The \(inputs.animal) was already opening it. \
            "\(inputs.sillySound)!" it said bravely, pushing through.

            On the other side was the most incredible kitchen in the universe. It was enormous — bigger than \
            their whole house! The counters were made of chocolate. The sink ran with lemonade. The oven was \
            shaped like a friendly dragon, and it hummed a little tune as it heated up.

            A cheerful wooden spoon with a face hopped up to them. "Welcome to the Magical Kitchen! I'm Stirry. \
            Everything you cook here comes to life!" \(inputs.heroName) and the \(inputs.animal) looked at \
            each other with huge eyes.

            "Let's make \(inputs.food)!" said \(inputs.heroName). "Excellent choice!" said Stirry. \
            "Ingredients are in the Dancing Pantry — but be careful, they like to play!"

            The Dancing Pantry was exactly what it sounded like. Every ingredient was dancing. The flour \
            was doing the waltz. The sugar was doing hip-hop. The butter was doing something that looked \
            like the macarena. The \(inputs.animal) started dancing too, and it was honestly better than \
            the butter.

            \(inputs.heroName) gathered up the dancing ingredients. Each one giggled when picked up. \
            "That tickles!" said the eggs. "Wheee!" said the milk as it poured itself into a measuring cup.

            They brought everything to the big mixing bowl, which spun itself like a merry-go-round. \
            \(inputs.heroName) added the ingredients one by one, and the bowl sang a different note with each one. \
            Soon it was playing a whole song! The \(inputs.animal) howled along: "\(inputs.sillySound)! \
            \(inputs.sillySound)! \(inputs.sillySound)!" It wasn't exactly in tune, but it was enthusiastic.

            The dragon oven opened its mouth and said "Ready when you are!" in a warm, rumbly voice. \
            \(inputs.heroName) slid the mixture inside. The oven closed its mouth, hummed louder, and \
            its cheeks turned \(inputs.color).

            DING! "All done!" said the oven, and it opened its mouth with a big smile. Inside was the most \
            beautiful \(inputs.food) \(inputs.heroName) had ever seen. It was \(inputs.color) and sparkly \
            and it smelled amazing.

            But then — the \(inputs.food) wiggled. It jiggled. It sprouted tiny arms and tiny legs and \
            a tiny face! "Hello!" it said in a squeaky voice. "Thank you for making me!"

            \(inputs.heroName) gasped. "It really does come to life!" The little \(inputs.food) hopped off \
            the tray and did a little dance. The \(inputs.animal) sniffed it carefully. The \(inputs.food) \
            booped the \(inputs.animal) on the nose. "\(inputs.sillySound)!" said the \(inputs.animal), \
            jumping back in surprise.

            More and more food came to life. A parade of tiny \(inputs.food) marched across the counter, \
            singing a silly song. A cupcake did backflips. A pile of mashed potatoes told jokes. A carrot \
            tried to do stand-up comedy, but everyone agreed the mashed potatoes were funnier.

            They all had a dance party right there in the Magical Kitchen. The dragon oven beat-boxed, \
            Stirry the spoon played air guitar, and \(inputs.heroName) and the \(inputs.animal) danced \
            with their new food friends until everyone was exhausted.

            "Will you come back and cook again?" asked the little \(inputs.food). "Definitely!" said \
            \(inputs.heroName). The \(inputs.animal) nodded its head so hard its ears flapped.

            They crawled back through the tiny \(inputs.color) door, through the pantry, and into their \
            regular kitchen. The door disappeared behind them. \(inputs.heroName) looked at the \(inputs.animal). \
            "Nobody would believe us," said \(inputs.heroName). The \(inputs.animal) had a tiny bit of \
            sparkly \(inputs.food) on its whiskers. "\(inputs.sillySound)!" it said, licking it off.

            From that day on, every rainy Saturday was cooking day. And if you listened very carefully \
            at the back of the pantry, you could hear tiny voices singing and a dragon oven humming along.

            The end.
            """
        },

        StoryTemplate(title: "The Cloud Hopper") { inputs in
            """
            \(inputs.heroName) discovered something amazing on a windy Tuesday afternoon. While jumping \
            on the trampoline in the backyard, \(inputs.heroName) bounced so high that — BOING! — they \
            landed on a cloud. An actual, real, fluffy cloud.

            "Whoa!" said \(inputs.heroName), looking down. The ground was far below. The trampoline looked \
            like a tiny dot. And the \(inputs.animal) was looking up with its mouth hanging open.

            "Come on up!" called \(inputs.heroName). The \(inputs.animal) backed up, took a running start, \
            jumped on the trampoline, and — "\(inputs.sillySound)!" — launched into the air and landed \
            right next to \(inputs.heroName) on the cloud.

            The cloud was soft and bouncy, like standing on a giant marshmallow. And it was moving! Slowly \
            drifting across the sky, carrying them over rooftops and trees and the park.

            "I wonder if we can jump to that one," said \(inputs.heroName), pointing to the next cloud over. \
            The \(inputs.animal) didn't wonder — it jumped. And landed perfectly! "\(inputs.sillySound)!" \
            it called back, very pleased with itself.

            \(inputs.heroName) jumped too. One cloud to the next, like stepping stones across a river. \
            Each cloud was different. Some were small and bouncy. Some were big and flat like beds. One was \
            shaped like a giant piece of \(inputs.food) — the \(inputs.animal) tried to eat it and got a \
            mouthful of mist.

            They hopped from cloud to cloud until they reached a particularly large, \(inputs.color) cloud. \
            On it was a little house made entirely of wind. The walls shimmered and the roof swirled. \
            A sign outside read: "Gusty's Cloud Stop — All Hoppers Welcome!"

            Inside, a friendly old wind spirit named Gusty was making \(inputs.food) behind a counter. \
            "Ah, cloud hoppers!" said Gusty. "Haven't had visitors in ages. Sit down, sit down!" Gusty \
            was a swirl of \(inputs.color) air with a kind face and a big laugh.

            Gusty served them plates of \(inputs.food) that floated slightly above the table. The \(inputs.animal) \
            chased its plate around in circles before finally pinning it down. "\(inputs.sillySound)!" it said \
            triumphantly, gobbling up the \(inputs.food).

            "Where are you two headed?" asked Gusty. "We don't really know," admitted \(inputs.heroName). \
            "We just started hopping!" Gusty's eyes twinkled. "Well then, you should visit \(inputs.place). \
            It looks magnificent from Cloud Level. I'll give you a boost."

            Gusty took a deep breath and blew the most gentle, perfect gust of wind. It carried \(inputs.heroName) \
            and the \(inputs.animal) up to a highway of clouds, all lined up in a row heading straight toward \
            \(inputs.place). "Thank you, Gusty!" yelled \(inputs.heroName). "Come back anytime!" \
            called Gusty, waving a swirly arm.

            They hopped along the cloud highway. Below them, the world was beautiful. Rivers sparkled like \
            silver ribbons. Fields were patchwork quilts of green and gold. \(inputs.heroName) could see \
            tiny people walking around, living their lives, not knowing that two cloud hoppers were having \
            the time of their lives right above them.

            The \(inputs.animal) started doing tricks — jumping between clouds with spins and flips. \
            It even did one jump where it tucked into a ball and rolled through a cloud, coming out the \
            other side looking like a fluffy cotton ball. "\(inputs.sillySound)!" it said, shaking off \
            the cloud fluff.

            Finally, they reached the biggest, most magnificent cloud right above \(inputs.place). \
            It was enormous and \(inputs.color), and from up there they could see everything — the whole \
            town, the mountains in the distance, and the ocean sparkling on the horizon.

            "This is the best view in the world," said \(inputs.heroName). The \(inputs.animal) sat beside \
            them, and they watched the sun slowly set, painting everything below in shades of orange and pink \
            and gold. The clouds around them turned \(inputs.color) and purple and rose.

            As the first stars appeared, the cloud they were sitting on started to sink. Slowly, gently, \
            like an elevator made of cotton candy. It carried them down, down, down, past the rooftops, \
            past the trees, and set them softly in their own backyard, right next to the trampoline.

            \(inputs.heroName) looked up at the sky. The clouds were still there, glowing faintly in the \
            moonlight. "Same time tomorrow?" asked \(inputs.heroName). The \(inputs.animal) looked up \
            at the clouds, then at the trampoline, then back at \(inputs.heroName), and said \
            "\(inputs.sillySound)!" with the biggest grin.

            And every windy day after that, if you looked up at just the right time, you might see two \
            small figures hopping from cloud to cloud, having the greatest adventure in the sky.

            The end.
            """
        },

        StoryTemplate(title: "The Nighttime Safari") { inputs in
            """
            \(inputs.heroName) couldn't sleep. The moon was full and huge and \(inputs.color) outside the \
            window. The \(inputs.animal) couldn't sleep either — it kept pacing back and forth, looking \
            outside with bright, curious eyes.

            "You want to go out there, don't you?" said \(inputs.heroName). The \(inputs.animal) nodded \
            so fast its whole body wiggled. "\(inputs.sillySound)!" it whispered excitedly.

            They tiptoed downstairs, quiet as mice. \(inputs.heroName) grabbed a flashlight and a backpack \
            with some \(inputs.food) for snacks. They slipped out the back door and into the moonlit night.

            Everything looked different at night. The backyard, which was so ordinary during the day, \
            was now silver and mysterious. Fireflies danced like tiny floating stars. Crickets played a \
            symphony. And the trees cast long, \(inputs.color) shadows that looked like friendly giants.

            "Let's go to \(inputs.place)," whispered \(inputs.heroName). "I bet it's amazing at night." \
            The \(inputs.animal) led the way, its nose twitching at all the new nighttime smells.

            The path to \(inputs.place) was lined with glowing mushrooms — tiny little lanterns that lit \
            up as \(inputs.heroName) walked by and dimmed after they passed. "It's like they're guiding us," \
            said \(inputs.heroName). The \(inputs.animal) sniffed one and it glowed \(inputs.color) extra \
            bright. "\(inputs.sillySound)!" whispered the \(inputs.animal), surprised.

            In the meadow, they saw their first nighttime animal. A family of rabbits was having a midnight \
            picnic! They were sitting in a circle on a tiny blanket, sharing what looked like... \(inputs.food)! \
            "Even the rabbits like \(inputs.food)!" giggled \(inputs.heroName). The tiniest rabbit waved a \
            little paw. The \(inputs.animal) waved back.

            Further along, they came to a pond. The water was so still it looked like a mirror, reflecting \
            the moon perfectly. A family of ducks was sleeping in a row, their heads tucked under their wings. \
            But one duckling was awake, paddling in quiet circles. It saw \(inputs.heroName) and the \
            \(inputs.animal) and quacked softly, as if to say "Nice night, isn't it?"

            At the edge of the pond, fireflies were putting on a show. They blinked on and off in patterns, \
            making shapes in the air — a star, a heart, and something that looked like a piece of \(inputs.food). \
            The \(inputs.animal) tried to catch one, leaping into the air with a quiet "\(inputs.sillySound)!" \
            The firefly landed on the \(inputs.animal)'s nose and blinked three times like a tiny flashlight.

            They reached \(inputs.place) just as the moon climbed to the very top of the sky. Everything \
            was bathed in silver light. Dewdrops on the grass sparkled like diamonds. A gentle breeze \
            made everything sway softly.

            And then \(inputs.heroName) saw something wonderful. In the clearing at \(inputs.place), all \
            the nighttime animals had gathered. Owls perched in the trees, their eyes like golden lanterns. \
            A fox sat quietly at the edge, its tail curled around its paws. A hedgehog waddled by carrying \
            a tiny berry. Three raccoons were playing a card game. A deer and its fawn stood majestically \
            in the moonlight.

            Nobody was scared. At night, all the animals were peaceful. They looked at \(inputs.heroName) \
            and the \(inputs.animal) and nodded, as if to say "Welcome to the nighttime world."

            \(inputs.heroName) and the \(inputs.animal) sat down in the soft grass. They shared their \
            \(inputs.food) with whoever wanted some — the raccoons were very interested, and the hedgehog \
            took a polite nibble. An owl flew down and perched on a branch right above them, humming a \
            soft melody.

            The \(inputs.animal) made friends with the fox. They touched noses and the fox showed the \
            \(inputs.animal) how to pounce at imaginary things in the grass. The \(inputs.animal) tried \
            it and landed in a heap. "\(inputs.sillySound)!" it said, and all the animals seemed to laugh \
            in their own quiet ways.

            \(inputs.heroName) lay back in the grass and looked up at the stars. There were millions of them, \
            more than they had ever seen. The \(inputs.animal) curled up beside them, warm and soft. \
            The owl kept humming. The fireflies kept blinking. The moon kept shining.

            "The nighttime isn't scary at all," said \(inputs.heroName). "It's actually kind of... magical." \
            The \(inputs.animal) sighed contentedly and said "\(inputs.sillySound)" so quietly it was almost \
            a purr.

            They must have fallen asleep right there in the moonlit clearing, because the next thing \
            \(inputs.heroName) knew, the first birds were singing and soft golden light was warming their face. \
            They were back in their own bed, the \(inputs.color) blanket pulled up tight, the \(inputs.animal) \
            snoozing at their feet.

            Had it been a dream? \(inputs.heroName) wasn't sure. But there was a tiny glowing mushroom \
            on the nightstand that definitely hadn't been there before. And the \(inputs.animal) had a \
            firefly gently blinking on its ear, still fast asleep.

            \(inputs.heroName) smiled, closed their eyes, and drifted back to sleep, already looking \
            forward to the next full moon.

            The end.
            """
        },

        StoryTemplate(title: "The Friendship Festival") { inputs in
            """
            A golden invitation slid under the door one morning while \(inputs.heroName) was eating \
            \(inputs.food) for breakfast. It was printed on \(inputs.color) paper in fancy gold letters. \
            The \(inputs.animal) grabbed it first and ran three laps around the kitchen before \(inputs.heroName) \
            could catch it. "\(inputs.sillySound)!" said the \(inputs.animal), which was not an apology.

            The invitation read: "You are invited to the Friendship Festival at \(inputs.place)! Bring your \
            best friend and something to share. Today at noon. Don't be late!"

            "A Friendship Festival!" said \(inputs.heroName). "And I already have the best friend in the world \
            right here." The \(inputs.animal) puffed up with pride. \(inputs.heroName) thought for a moment. \
            "And we should bring \(inputs.food) to share. Everyone loves \(inputs.food)!"

            They spent the whole morning cooking. \(inputs.heroName) stirred and the \(inputs.animal) taste-tested. \
            Every few minutes the \(inputs.animal) would stick its face in the bowl and come up with \(inputs.food) \
            all over its nose. "\(inputs.sillySound)!" it would say, licking its chops. They made enough \
            \(inputs.food) to share with the whole festival.

            At noon, they arrived at \(inputs.place). It was completely transformed. There were \(inputs.color) \
            banners hanging from every tree. A band of musical frogs was playing on a stage made of lily pads. \
            Streamers crisscrossed overhead, and the air smelled like cotton candy and \(inputs.food).

            Friends were everywhere! Some had come in pairs, some in groups. Everyone brought something to share. \
            A girl and her parrot brought homemade friendship bracelets. Twin brothers brought a wagon full of \
            board games. An old man and his three cats brought the biggest pie anyone had ever seen.

            The first event was the Three-Legged Race. \(inputs.heroName) and the \(inputs.animal) tied their \
            legs together with a \(inputs.color) ribbon. "Ready?" said \(inputs.heroName). "\(inputs.sillySound)!" \
            said the \(inputs.animal), already trying to run. They stumbled and wobbled and zigzagged their way \
            down the track. The \(inputs.animal) kept going left when \(inputs.heroName) went right. They fell \
            down four times. They came in dead last. And they laughed harder than anyone.

            Next was the Talent Show. Every pair of friends did an act together. The twins juggled while standing \
            on each other's shoulders. The girl and her parrot sang a duet. The old man's cats did synchronized \
            napping, which the judges said counted as performance art.

            When it was \(inputs.heroName)'s turn, they didn't have a plan. "What should we do?" whispered \
            \(inputs.heroName). The \(inputs.animal) whispered "\(inputs.sillySound)" and then did the funniest \
            thing — it stood on its back legs and started doing an impression of \(inputs.heroName). It walked \
            around pretending to be very serious, then pretended to eat \(inputs.food) in the most dramatic \
            way possible, then struck a pose.

            The crowd went crazy laughing. \(inputs.heroName) started doing an impression of the \(inputs.animal) \
            right back — getting on all fours, sniffing everything, and yelling "\(inputs.sillySound)!" at imaginary \
            squirrels. The audience was in tears. They won first place.

            Then it was time for the Great Sharing Circle. Everyone sat in a huge circle at \(inputs.place) \
            and passed around what they had brought. The friendship bracelets went around — \(inputs.heroName) \
            got a \(inputs.color) one and the \(inputs.animal) got a tiny one for its paw. The board games \
            were set up and little groups started playing. The giant pie was cut into a hundred pieces.

            And \(inputs.heroName)'s \(inputs.food) was the biggest hit of all. Everyone loved it. People \
            came back for seconds and thirds. The \(inputs.animal) was very proud, even though its main \
            contribution had been taste-testing, which is honestly the most important job.

            As the sun went down, the musical frogs played one last slow song. Everyone gathered together, \
            new friends and old friends and animal friends. Someone had strung up \(inputs.color) lanterns \
            in the trees, and they glowed softly as the sky turned purple.

            The festival organizer, a friendly woman with flowers in her hair, stood up. "The Friendship \
            Festival isn't about the games or the food or the prizes," she said. "It's about this — all \
            of us, together, right now."

            \(inputs.heroName) looked at the \(inputs.animal), who was wearing its friendship bracelet and \
            its talent show ribbon and had \(inputs.food) crumbs all over its face. It looked ridiculous \
            and perfect. "You're my best friend in the whole world," said \(inputs.heroName).

            The \(inputs.animal) leaned against \(inputs.heroName) and said "\(inputs.sillySound)" very \
            softly. It didn't need translation. Some things you just know.

            They walked home under the \(inputs.color) lantern light, full of \(inputs.food) and full of \
            happiness. And that night, \(inputs.heroName) put the golden invitation on the nightstand where \
            they could see it every morning and remember: the best thing in the world is a really good friend.

            The end.
            """
        },
    ]

    static func random() -> StoryTemplate {
        all.randomElement()!
    }
}
