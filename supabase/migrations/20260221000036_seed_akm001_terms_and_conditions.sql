-- Seed AKM-001 for staging reader smoke tests
INSERT INTO public.fiamma_books (
  title_id, title, slug, heteronym, genre, fiamma_line, blurb_short, blurb_300, cover_url, isbn_pb, isbn_eb, isbn_audio, visible
) VALUES (
  'akm-001-terms-and-conditions',
  'Terms and Conditions',
  'terms-and-conditions',
  'Aubrey Kenneth-Moss',
  'Romance',
  'Contemporary',
  'A novel about a corporate attorney and a tech founder navigating the verifiable three inches between proof and promise.',
  'Berna Alvarez is a corporate liability attorney who believes in proof, not promises. Sam Reyes is a tech founder who builds mobility solutions that Berna''s firm would rather litigate out of existence. When an asbestos-induced exile forces Berna into the shared workspace of Sam''s start-up, the resulting collision of legal risk and technological optimism creates a friction that neither can document away. ''Terms and Conditions'' is a novel about the small, verifiable distance between two people who know exactly who the other is, and choose to bridge it anyway.',
  '/assets/covers/terms-and-conditions.jpg',
  '978-1-917717-24-3',
  '978-1-917717-25-0',
  '978-1-917717-26-7',
  true
)
ON CONFLICT (title_id) DO UPDATE SET
  title = EXCLUDED.title,
  slug = EXCLUDED.slug,
  heteronym = EXCLUDED.heteronym,
  genre = EXCLUDED.genre,
  fiamma_line = EXCLUDED.fiamma_line,
  blurb_short = EXCLUDED.blurb_short,
  blurb_300 = EXCLUDED.blurb_300,
  cover_url = EXCLUDED.cover_url,
  isbn_pb = EXCLUDED.isbn_pb,
  isbn_eb = EXCLUDED.isbn_eb,
  isbn_audio = EXCLUDED.isbn_audio,
  visible = EXCLUDED.visible,
  updated_at = now();

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  1,
  'Chapter 1',
  $akm001ch1$
# Chapter 1

The asbestos wasn't even my fault.

This is what I keep telling myself as I stand outside Forge & Flow Creative Collective, which is Portland-speak for "we subdivided a warehouse and installed Edison bulbs." The building used to be a mattress factory, and apparently the original owners believed that nothing said "quality sleep" like wrapping everything in carcinogenic insulation. Now it houses seventeen startups, a pottery collective, and me: a corporate liability attorney whose firm just discovered that their newly renovated third floor contains enough friable asbestos to qualify as a Superfund site.

Remediation takes six weeks. My caseload doesn't pause for carcinogens. Hence: exile.

Gloria delivered the news yesterday with the particular blend of sympathy and satisfaction she reserves for situations she finds genuinely unfortunate but also, on some level, hilarious. She called me into her office at 4:47 PM, which should have been my first warning. Gloria doesn't do late-afternoon meetings unless someone is getting fired or reassigned to asbestos purgatory.

"The good news," she said, leaning back in her chair, "is that you're not dying."

"The bad news?"

"You're relocating." She slid a folder across her desk. Inside: a keycard, a printout of coworking space amenities, and a map with a red circle around a building in the Central Eastside that I'd probably walked past a hundred times without registering it existed. "Temporarily. Six weeks, maybe seven."

"Gloria."

"It's either this or you work from home, and we both know how that went during Covid. You called me seventeen times in one day. About fonts."

"They were using Papyrus on a contract."

"It was urgent enough to interrupt my daughter's birthday party?"

"Papyrus, Gloria. On a legally binding document."

She handed me the keycard. "Forge & Flow. It's very Portland. You'll hate it. But they have wifi and twenty-four hour access and none of the walls are trying to kill you, so I consider that an upgrade."

The printout lists the amenities. They include: high-speed wifi, unlimited coffee, and "a vibrant community of innovators."

I am not an innovator. I am a person who finds holes in other people's innovations so my clients don't get sued. This is not the same thing, no matter what the inspirational poster in the elevator says about "legal creativity."

The elevator poster says MAKE MISTAKES FASTER in all caps. Someone has added, in smaller letters beneath it, "but document everything." I appreciate this anonymous contributor. They understand liability.

I spend my professional life ensuring that companies make mistakes slower, or ideally, not at all. The cognitive dissonance of my new environment is going to give me a rash.

Forge & Flow occupies the third floor. The stairwell smells like roasted coffee and something herbal I choose not to identify, though I'm reasonably certain it's legal in Oregon. The door requires both the keycard and a four-digit code that Gloria texted me this morning. The code is 1234. I'm surrounded by innovators who apparently believe security is something that happens to other people.

Inside, the space unfolds in calculated chaos. Exposed brick, exposed ductwork, exposed everything. The design aesthetic appears to be "what if we removed all the parts of a building that make it a building and then charged people to sit in what remains." There are actual humans here, scattered across clusters of mismatched furniture like extras in a commercial for collaborative energy drinks. Some of them appear to be working. Some of them appear to be having meetings about having meetings. One of them, a woman with lavender hair and an alarming number of crystals arranged on her desk, is having an intense conversation with a fern.

"You're not communicating your needs," she tells the fern. The fern says nothing. This seems to frustrate her.

A man in a beanie is doing pushups between two standing desks while another man times him on his phone. Neither of them seems to find this unusual. Perhaps pushups between desks is simply what one does at Forge & Flow. Perhaps I've been approaching professional development wrong my entire career.

The massive chalkboard wall stretches across the north side of the room, and someone has written on it in enthusiastic cursive: "WHAT WOULD YOU ATTEMPT IF YOU KNEW YOU COULD NOT FAIL?"

I would attempt to sandblast that question off the wall. That's what I would attempt.

Beneath the main question, various people have added their own answers. "Start a podcast!" says one. "Learn to surf!" says another. "Disrupt the dairy industry!" says a third, with several exclamation points for emphasis. The dairy industry has not, to my knowledge, asked to be disrupted, but I suppose that's the nature of disruption.

My designated workspace is in the back corner, separated from the main floor by a partition wall that stops about two feet short of the ceiling. This is apparently a "semi-private pod," which means I can hear everything but see nothing, like a very poorly designed confessional. The architect who thought this was adequate sound separation should be brought before a professional ethics board.

I set down my laptop bag. I set down my second laptop bag, the one with the backup charger and the emergency granola bars and the three legal pads I refuse to travel without. I set down the file box that contains three active matters I refuse to let out of my sight while the main office undergoes what the remediation team cheerfully calls "aggressive abatement." Then I sit in my ergonomic chair, which is not ergonomic, and I contemplate the partition wall.

The partition wall is covered in cork. The cork is covered in layers of paper: flyers for yoga classes ("find your flow at Flow Yoga!"), business cards for "brand alchemists" and "innovation catalysts," a photo of someone's dog wearing a startup t-shirt that says "I'm Crushing It." There's a small whiteboard mounted at eye level with DRY ERASE ONLY written on it in what appears to be permanent marker. This feels like a metaphor for something, but I refuse to explore what.

On the other side of the wall, someone is building something.

I know this because I can hear it. Drilling. Sawing. The occasional triumphant "HA!" followed by what sounds like wood hitting the floor. It's 9:47 in the morning and my new neighbor is constructing what might be furniture, might be a catapult, might be a noise violation in progress.

I put on my headphones. The noise continues, undeterred by Bluetooth technology and the entire discography of what Spotify insists is "focus music." I turn up the volume. The drilling gets louder, as if in direct response, as if my neighbor has somehow detected my attempt to escape and decided to escalate. I consider the legality of partition-wall arson and determine it's probably not covered under "reasonable workplace accommodation."

My phone buzzes.

**Lena:** How's the refugee camp?

Lena has been my best friend since law school, when we bonded over shared hatred of a Property professor who pronounced "easement" like it was a communicable disease. She's a public defender now, which means she works twice as hard as me for half the money and has infinitely better stories. She once spent three hours convincing a judge that her client hadn't technically stolen a boat because the boat was "spiritually communal property." She lost, but everyone agreed it was an impressive argument.

She's also the only person I've told about the asbestos situation who didn't immediately make a mesothelioma commercial joke.

**Me:** There's a chalkboard that asks what I would attempt if I couldn't fail.

**Lena:** Murder?

**Me:** The list is long.

**Lena:** How's the actual space?

**Me:** Someone is building something loud on the other side of my wall. It's been 12 minutes. I've already drafted a cease and desist in my head.

**Lena:** You know you can't actually serve legal documents on fellow coworking members.

**Me:** Watch me.

**Lena:** This is why you don't have friends.

**Me:** I have you.

**Lena:** I'm a hostage, not a friend. We've discussed this.

**Me:** You keep coming back.

**Lena:** Stockholm syndrome. Look, just give it a chance. Maybe the hammering guy is hot.

**Me:** Irrelevant.

**Lena:** It's never irrelevant. Let me know if he's hot.

**Me:** I'm hanging up.

**Lena:** This is a text conversation.

**Me:** I'm hanging up spiritually.

The drilling stops. I allow myself thirty seconds of hope. Perhaps my neighbor has run out of materials. Perhaps they've injured themselves and will require a quiet recovery period. Perhaps they've achieved whatever chaotic goal they were pursuing and can now exist in blessed, productive silence.

Then it's replaced by hammering, which is somehow worse because there's a rhythm to it, an almost-pattern that my brain keeps trying to predict and failing. Tap-tap-TAP. Tap-tap-TAP. Tap-tap-tap-TAP. No. Wrong again. My brain keeps reaching for the pattern like a hand reaching for a doorknob that isn't where it should be. It's maddening in a very specific way that I suspect is intentional.

I decide to get coffee. This is strategic: it allows me to scout the enemy territory without appearing to scout the enemy territory. I'm simply a woman seeking caffeine, not a woman planning acoustic warfare. Reconnaissance is not a crime.

The coffee station is exactly what I feared. There's a commercial espresso machine that looks like it was designed by someone who hates both coffee and the humans who drink it. Buttons everywhere, no clear indication of which buttons do what, a small screen displaying Italian words I don't recognize. There are seven different types of alternative milk, none of which appear to be actual milk. Oat. Almond. Cashew. Macadamia. Something called "barista blend" which seems redundant. Something else called "planet milk" which seems ominous. Regular dairy is nowhere to be found, possibly because it remains undisrupted.

There's a laminated sign that says "TAKE ONLY WHAT SPARKS JOY" with a hand-drawn Marie Kondo underneath, and I genuinely cannot tell if it's sincere or ironic, which might be worse than either option.

The carafe is empty. There's a note on it that says "Please make more if you take the last cup! We're all in this together! :)"

I was not in this with anyone. I was in exile. There's a difference.

I start making coffee because I'm not an animal, despite what my internal monologue suggests. The machine makes concerning noises. I make concerning noises back at it, quietly, under my breath, because I'm not about to be defeated by an Italian coffee apparatus. We reach an understanding, which involves me pressing buttons at random until something brown and caffeinated emerges.

While the coffee brews, I survey the floor. The partition wall blocks my view of my immediate neighbor, but I can see around it to the wider space. Beanie Pushup Man is now doing squats. Lavender Fern Woman is now on a call, gesturing emphatically at nothing, telling someone that the energy is "so blocked right now, so blocked." A cluster of people who all look like they share a Patagonia sponsorship are huddled around a whiteboard, drawing what might be a user flow or might be an elaborate plan for world domination. Hard to tell with startups.

The hammering from my side of the partition has stopped. Small mercies.

I pour my coffee. It's not good, but it's coffee, and at this point I'd accept bean water filtered through a gym sock if it contained caffeine. I head back to my pod, already mentally organizing my first task: a contract review for a medical device company that somehow thinks "best efforts" and "commercially reasonable efforts" are the same thing. They're not. They're very, very not. "Best efforts" means you have to try everything possible. "Commercially reasonable" means you have to try everything that a sensible business would try. The distinction has generated approximately a billion dollars in litigation. This is going to take all day, which is fine. All day is exactly what I have.

I round the corner to my desk.

There's a Post-it note on my monitor.

It's bright yellow, stuck dead center on the screen, impossible to miss. The handwriting is angular, confident, almost aggressive in its clarity. It says:

*Sorry about the noise! Building something cool. Promise it'll be worth it. - S*

I stare at the note. I stare at it for a long time. My right eye twitches, just slightly, a tic I developed in law school during finals week that only emerges under specific conditions of irritation. Not because of the noise, though the noise is objectionable. Not because someone touched my monitor, though that's also objectionable. Because of the promise.

*Promise it'll be worth it.*

No. No, it will not be worth it. Nothing that requires that much hammering at 9:47 AM is worth anything to anyone except the person doing the hammering. This is a fundamental truth of shared spaces. The value of your project is inversely proportional to its volume. This is basically physics. This is Newton's Fourth Law, the one he didn't publish because it was too obvious.

I pull a Post-it from my own pad. It's blue. I write in my best courtroom handwriting, the one that makes opposing counsel nervous, the one I use for exhibit labels and passive-aggressive interoffice memos:

*Cool is subjective. Noise ordinances are not. Please limit construction to designated hours. - B*

I walk around the partition wall for the first time.

My neighbor's space is chaos. Organized chaos, maybe. The kind of chaos that suggests a system exists, even if that system is "put things where they land and hope for the best." There are sketches everywhere, pinned to the cork, taped to the desk, layered on top of each other like geological strata. Designs for something, though I can't tell what. Circular things. Mechanical things. Things with arrows pointing to other things. The desk itself is buried under components I can't identify: small motors, coils of wire, what might be part of a hinge mechanism, a soldering iron, a half-eaten granola bar, three empty coffee cups in various stages of abandonment.

The chair is empty. A jacket hangs over the back, worn canvas that looks like it's been through several adventures and doesn't regret any of them. There's a small cactus on the corner of the desk wearing, inexplicably, a tiny hard hat.

I stick my Post-it on his monitor. Center screen. Exactly where he put his.

Then I go back to my side of the wall.

For forty-five minutes, there's peace. Beautiful, productive peace. I draft three pages of contract markups. I send fourteen emails. I make another terrible cup of coffee. I begin to believe that maybe, possibly, this arrangement could be survivable. The lavender woman has stopped talking to her fern. The pushup man has finally sat down. Even the chalkboard has stopped offending me, or at least I've stopped looking at it.

The drilling starts again at 11:32.

I put my headphones back on. I draft a mental list of crimes that are legal in Oregon. (None of the ones I'm considering.) I contemplate whether six weeks is long enough to develop a noise-related medical condition and whether that would constitute grounds for early return to the asbestos office. The asbestos suddenly seems more manageable than my neighbor.

At 11:47, a new Post-it appears on my monitor.

I didn't see anyone enter my space. I didn't hear anyone enter my space, though to be fair, I couldn't hear anything over the industrial cacophony next door. But there it is: yellow, centered, that same angular handwriting.

*Designated hours are 9-6. It's 11. I checked the handbook! - S*

*P.S. What does B stand for?*

Oh.

Oh no.

This person knows the handbook. This person has READ the handbook, which is more than I did before writing my note, which means I've just been out-procedured by someone who thinks "building something cool" is an adequate explanation for construction noise. This person is using the handbook against me, which is my move, that's literally what I do for a living, and I'm now on the receiving end of weaponized compliance and I don't know how to feel about it except furious and possibly a little impressed.

No. Not impressed. Furious. Only furious.

I write back, blue Post-it, same precise handwriting:

*B stands for none of your business.*

*P.S. The handbook also requires "reasonable consideration for neighboring workspaces." Consider this your notice.*

I walk to his side. Chair still empty. Jacket still there. Cactus still wearing its hard hat, which feels like mockery now. I stick the note exactly where he'll see it.

I go back to my desk. I try to focus. The contract blurs in front of me, "best efforts" and "commercially reasonable" swimming together until they're meaningless, which is perhaps how my client sees them, which is why I'm here in the first place.

At 12:15, the drilling stops. There's silence for exactly ninety seconds. I count them. Then:

Laughter.

It's coming from the other side of the wall, and it's not performative laughter, not the kind people produce for conference calls or networking events. It's real. Surprised. Like someone just discovered something delightful and couldn't help the sound that came out, like the laugh was dragged from them against their will.

It's a good laugh. Not that I'm cataloging it. I'm not keeping notes on my neighbor's acoustic output. It's just objectively, acoustically pleasant. Warm. Full. The kind of laugh that makes you want to know what prompted it, even when you're annoyed at the person laughing. Maybe especially then.

I put my headphones on.

I do not think about the laugh.

I'm here for six weeks. I'm going to survive this by compartmentalization and caffeine and the knowledge that asbestos remediation has a fixed timeline and so does my patience.

At 12:23, another Post-it appears.

*B = Brilliant? Beautiful? Belligerently opposed to innovation?*

*P.S. The building is done. Silence commences. You're welcome.*

*P.P.S. I'm Sam.*

I read it twice. I read it three times. "Belligerently opposed to innovation" is not wrong, exactly, but it's not the framing I would have chosen. I prefer "appropriately skeptical of unverified claims." This is not the same thing.

I don't write back. I have work to do. Real work, the kind that requires concentration and silence and an absence of angular handwriting on yellow squares of paper.

But I keep the note.

I keep all of them.

I'm going to need evidence.

For what, exactly, I don't specify. Even to myself.

$akm001ch1$,
  3091
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  2,
  'Chapter 2',
  $akm001ch2$
# Chapter 2

Day three, and I've developed a system.

The system is this: I arrive at 8:45, fifteen minutes before the handbook-sanctioned construction window opens. I make my terrible coffee. I settle into my semi-private pod with my noise-canceling headphones already in place, volume at maximum, playing a Spotify playlist called "Deep Focus for Productivity" that sounds like someone recorded a thunderstorm inside a library. By the time the drilling starts at 9:00 sharp, I'm already insulated. Protected. Professionally detached from whatever chaos is happening on the other side of the partition wall.

The system works for approximately forty-seven hours.

It fails on Thursday morning because I run out of oat milk.

This is not, technically, my fault. The oat milk situation at Forge & Flow operates on a first-come, first-served basis, and someone has been coming firster and serving themselves more generously than the social contract allows. I've been tracking the depletion rate. Monday: full carton. Tuesday: three-quarters. Wednesday: half. Thursday, 8:52 AM: empty. Someone is drinking my oat milk, and by "my" I mean "the communal oat milk that I have a reasonable expectation of accessing given my early arrival time and consistent contribution to the coffee station maintenance fund."

I do not contribute to the coffee station maintenance fund. I didn't know there was one until just now, when I noticed the jar with the handwritten sign that says "COFFEE KARMA: $2/week keeps the beans flowing!" The jar contains seven dollars and a button.

I put in two dollars. I'm not an animal.

But the oat milk is still empty, and the almond milk smells like it's been here since the Clinton administration, and the "planet milk" has a texture I refuse to investigate, which leaves me standing in front of the coffee station at 8:54 AM without my protective headphones, holding an empty carafe, trying to figure out how to make this machine produce something drinkable with whatever dairy-adjacent substance I can scavenge.

"The trick is the third button."

I turn around.

He's taller than I expected. This is the first thing I notice, which is stupid, because I had no expectations about his height. I'd never seen him. I'd only heard him: the drilling, the hammering, the laugh. But somehow my brain had constructed a mental image based on acoustic data alone, and that image was apparently shorter. More compact. Less... present.

Sam is very present.

He's wearing a flannel shirt with the sleeves rolled up to his elbows, which should look like a Portland cliché but instead just looks like a person who runs warm. His hair is dark and doing something architectural that suggests either careful product application or complete indifference to gravity. He's holding a mug that says "I PUT THE PRO IN PROTOTYPE" and smiling like he's been waiting three days to deliver this line.

"The third button," he repeats, pointing at the espresso machine. "The one that looks like a bean with a hat. Everyone presses the first two and wonders why it tastes like regret."

"I wasn't pressing any buttons."

"You were staring at them with hostility. Same energy."

"I was assessing my options."

"Your options are: button three, or the cold brew in the fridge that Derek made on Monday and forgot about. I don't recommend the cold brew. Derek's brewing philosophy is 'more grounds equals more flavor' and he's not entirely wrong but he's not entirely right either."

I look at the machine. I look at him. I look at the machine again.

"Which one is the bean with a hat?"

He steps closer, reaching past me to point at a small icon on the control panel that does, in fact, appear to be a coffee bean wearing some kind of festive headwear. His arm brushes mine. It's brief. It's accidental. It's also the first time anyone has touched me in three days, which is a pathetic thing to notice and I'm going to stop noticing it immediately.

"That one. Press it twice for a double shot, once for a reasonable human dose. Unless you're a double-shot person, in which case, respect."

"I'm a 'whatever makes this interaction end faster' person."

He laughs. It's the same laugh I heard through the wall, warm and surprised, and hearing it this close is different. Worse. Better. I press the bean-with-hat button once and wait for the machine to do its job.

"I'm Sam," he says, extending his hand. "The neighbor. The noisy one. The Post-it correspondent."

I shake his hand because that's what you do when someone offers you a handshake in a professional setting, even if the professional setting is a converted mattress factory with inspirational chalkboard graffiti. His grip is firm but not aggressive. His palm is warm. He has calluses on his fingers, which suggests he actually builds things with his hands instead of just supervising other people who build things.

"Berna," I say, and then, because he's looking at me like he expects more: "The neighbor. The quiet one. The Post-it recipient."

"Berna." He says my name like he's testing how it feels in his mouth, which is a weird thing to think and I'm going to stop thinking it. "That's what the B stands for."

"That's what the B stands for."

"I had money on Belligerent."

"You lost."

"I usually do." He's still smiling. The smile is doing something to his face that makes it hard to look at directly, like staring at a lamp. "So, Berna. How are you finding the creative collective experience?"

"Loud."

"Fair."

"Disruptive."

"Also fair."

"The chalkboard makes me want to commit arson."

"Now that's interesting." He leans against the counter, apparently settling in for a longer conversation than I authorized. "Most people have strong feelings about the coffee or the parking situation. You went straight for the inspirational messaging."

"The coffee is terrible and I take the bus."

"The coffee's not that bad if you use button three."

"The coffee is a war crime against beans."

"Okay, the coffee's pretty bad." He takes a sip from his prototype mug, wincing slightly. "But the location's good and the rent is reasonable and there's a pottery collective on the second floor that makes really incredible bowls. I bought one for my mom. She uses it for keys."

"Why are you telling me about your mother's key bowl?"

"Because you asked about my experience with the creative collective and I'm giving you the full picture. Location, rent, artisanal ceramics. The trifecta."

"I didn't ask about your experience. I answered a question about mine."

"Right, but the conversation was going well and I didn't want it to end."

The espresso machine beeps. My coffee is ready. I have no reason to continue standing here, listening to a man with architectural hair explain his mother's key storage solutions.

"Thank you for the button advice," I say, reaching for my cup.

"Anytime. And hey, I really am sorry about the noise. The prototype's almost done. Another few days and I'll be back to peaceful computer work like a normal coworking denizen."

"What's the prototype?"

I don't know why I ask. I don't care about the prototype. I have three contracts to review and a call with Gloria at ten and a growing suspicion that the ergonomic chair is actually causing my back problems rather than solving them. I do not have time to learn about whatever innovation is happening on the other side of my partition wall.

But I ask anyway.

Sam's face does something complicated. It's like watching someone try to contain an explosion of enthusiasm behind a wall of social appropriateness. "It's a... okay, so you know how assistive devices for mobility are either really medical-looking or really expensive or both?"

"I'm aware of the assistive device market, yes."

"You are?"

"I'm a corporate liability attorney. I'm aware of every market that might result in a lawsuit."

"God, that must be exhausting."

"You have no idea."

He laughs again. I'm going to have to develop an immunity to that laugh. It's not sustainable, feeling something in my chest every time he finds me funny.

"Anyway," he continues, "I'm trying to build something that's functional but also actually nice to look at. Design-forward accessibility. There's a whole philosophy about it, about how objects for disabled people shouldn't look like medical equipment if they don't have to, and I just," He stops, catches himself mid-spiral. "Sorry. I get excited. It's a whole thing."

"A thing you've been building at high volume since Monday."

"The drilling is because I'm working with a new hinge mechanism. Metal on metal. I know it's terrible. I bought you chocolate."

"You bought me chocolate?"

"It's on your desk. Well, on your monitor. I was going to leave another Post-it but that felt like escalation and I wanted to de-escalate. Chocolate seemed diplomatic."

I think about the Post-it war. I think about the notes I've been keeping, the evidence I told myself I was collecting for some unspecified future purpose. I think about the fact that this person heard my complaints about noise and responded by buying me chocolate.

"What kind of chocolate?"

"The fancy kind from that place on Division. The one with the salted caramel that costs more than it should."

"That's a twelve-dollar chocolate bar."

"Is it? I wasn't paying attention to the price. I was paying attention to the lady who told me it was the best one for apologizing to a neighbor you've been annoying. She seemed like an expert."

"You asked a stranger for chocolate advice."

"I ask strangers for advice constantly. It's very effective. People love being helpful."

I don't know what to do with this information. I don't know what to do with any of this. I came to the coffee station to make a beverage and instead I'm having a conversation with a person who buys expensive apology chocolate and gets excited about hinge mechanisms and has a mother with a key bowl.

"I should get back to work," I say.

"Right, yes, absolutely. Me too. Things to drill. Hinges to hinge." He steps back, giving me space to leave. "It was nice to officially meet you, Berna. You know, face-to-face instead of Post-it-to-Post-it."

"It was... informative."

"I'll take informative. Informative is good."

I walk back to my pod. The chocolate is exactly where he said it would be: dead center on my monitor, a small rectangle of expensive brown wrapped in paper that probably costs three dollars on its own. There's no Post-it. Just the chocolate.

I put it in my drawer. I don't eat it. Eating it would feel like accepting something, and I'm not ready to accept anything.

I put my headphones on. I open my contracts. I do not think about the laugh, or the calluses, or the way he said my name.

The drilling starts at 9:00.

At 10:15, the coffee machine explodes.

"Explodes" is a strong word. "Experiences a catastrophic failure involving pressurized water and an apparent weakness in the steam valve" is more accurate, but accuracy doesn't capture the visceral shock of walking to the coffee station for a refill and finding Sam standing in a spreading puddle, holding a wrench, looking at the espresso machine like it personally betrayed him.

"I can fix this," he says.

The machine makes a noise like a dying whale.

"I can definitely fix this."

Water is spraying from somewhere inside the machine in a fine, persistent mist. The counter is soaked. The floor is soaked. Sam is soaked. Lavender Fern Woman is standing in the doorway with her mouth open, holding a crystal that's supposed to promote clarity but is apparently not promoting it fast enough.

"Did you take the machine apart?" I ask.

"I was trying to improve it. The third button wasn't pulling shots consistently and I thought if I adjusted the,okay, in retrospect, I should not have done this."

"In retrospect."

"I have a lot of confidence in my mechanical abilities and sometimes that confidence is misplaced."

The mist is hitting my face. I'm going to need to redo my makeup. I'm going to need to redo my entire morning.

"Turn off the water," I say.

"What?"

"The water. Turn it off. There's a valve under the sink."

He looks at me. He looks at the sink. He drops to his knees and crawls under the counter, emerging a moment later with a triumphant expression and significantly wetter pants. "Found it."

The mist stops. The whale noise subsides. We're left standing in a flooded kitchenette with a disassembled espresso machine and what appears to be the entire third floor of Forge & Flow gathering to observe the aftermath.

"I can fix this," Sam says again, to the crowd this time.

"Maybe we should call a professional," suggests Beanie Pushup Man, who has appeared from somewhere and is now doing lunges in the doorway, apparently unable to stop exercising even during a crisis.

"I am a professional. I build things. This is a thing. I can build it back."

"You took apart the communal coffee machine," I say. "On a Thursday. When people need coffee."

"I took apart the communal coffee machine because the communal coffee machine was failing to meet its full potential and I thought I could help."

"And instead you flooded the kitchen."

"The flooding is temporary. The improved functionality will be permanent." He's pushing wet hair out of his face, leaving a streak of something mechanical-looking across his forehead. He looks like a disaster. A very specific kind of disaster that my brain is filing under "appealing" despite my explicit instructions to file it under "annoying."

I should walk away. I should return to my pod, dry off my face, and let the creative collective handle its own infrastructure problems. This is not my coffee machine. This is not my mess. This is not my problem.

"Give me the wrench," I say.

"What?"

"The wrench. The one in your hand. Give it to me."

He hands it over, looking at me like I've just announced I can speak to dolphins. I crouch down next to the machine, ignoring the water soaking into my work pants, and look at what he's done.

It's chaos. But it's organized chaos. The parts are laid out in a pattern that suggests he knew what he was doing, even if what he was doing was inadvisable. I can see where he was trying to adjust the pressure valve. I can see where it went wrong.

"You overtightened this," I say, pointing at a small fitting. "That's why it's leaking. The seal cracked."

"How do you know that?"

"My uncle runs a restaurant. I've fixed coffee machines before."

"You've fixed coffee machines before and you didn't tell me when I was explaining button three?"

"You didn't ask if I could fix coffee machines. You asked which button made it work."

I'm aware that we're very close together. I'm aware that his arm is near mine again, that I can smell whatever soap he uses, something clean and slightly woodsy. I'm aware that my hands are occupied with a wrench and a broken fitting and that this is a very strange context for physical awareness.

"There's a replacement seal in the maintenance closet," says a voice behind us. It's Lavender Fern Woman, who has apparently decided to be helpful. "Third shelf, behind the backup paper towels."

"Thank you," I say.

"The machine has been acting weird for weeks. Someone should have fixed it ages ago. The energy around the coffee station has been very blocked."

"I'll... unblock it."

Sam goes to get the seal. I wait, crouched in the puddle, holding parts of a machine I have no professional obligation to repair. This is not in my job description. This is not in anyone's job description. I'm a liability attorney. I identify risks. I don't fix espresso machines in flooded kitchenettes while a man with callused hands fetches replacement seals.

He comes back. He hands me the seal. Our fingers touch during the transfer, and it's not like the earlier brush of his arm. This is direct. Intentional. His hand pausing on mine for a half-second longer than necessary.

"You're really going to fix it?" he asks.

"Someone has to."

"I could help. I'm good with my hands."

"You're the reason it's broken."

"I prefer to think of myself as the reason it's about to be better."

I don't respond. I replace the seal. I reassemble the valve. I tighten everything to the correct pressure, not overtightened, not loose, exactly where it should be. When I turn the water back on, nothing sprays. When I press button three, the machine hums to life and produces a perfect shot of espresso.

The small crowd that has gathered actually applauds. Beanie Pushup Man does a celebratory burpee.

"You're a genius," Sam says.

"I'm a person who has fixed coffee machines before."

"Same thing." He's beaming at me like I just solved world hunger instead of replacing a three-dollar seal. "Can I buy you a coffee? From the machine you just fixed? Using the skills you apparently possessed this whole time and never mentioned?"

"I have a call in fifteen minutes."

"A quick coffee. A thank-you coffee. A 'you just saved the third floor from caffeine withdrawal' coffee."

I look at the machine. I look at him. I look at the puddle we're both standing in, the water soaking into our shoes, the absurdity of this entire situation.

"Fine," I say. "One coffee."

He makes me a double shot. He uses button three. It's the best coffee I've had since I started working at Forge & Flow, which isn't saying much, but it's saying something.

"So," he says, handing me the cup. "Liability attorney who fixes coffee machines. That's an interesting combination."

"So," I say, accepting it. "Product designer who breaks coffee machines. That's an interesting combination too."

"I prefer 'ambitious improver.' It sounds less destructive."

"It sounds like something you'd put on a LinkedIn profile to hide the fact that you flooded a kitchen."

He laughs. There it is again. That sound. I'm going to need to stop noticing that sound.

"I should get back," I say. "The call."

"Right. The call." He doesn't move. Neither do I. We're standing in the middle of a slowly drying puddle, holding coffee cups, not leaving.

My phone buzzes. Gloria. Five minutes until our call.

"I have to go," I say.

"I know."

"The chocolate was unnecessary."

"I know that too."

"But thank you. For the gesture."

"Anytime." He's still smiling. He's always smiling. It's exhausting and disarming and I need to get away from it before I start smiling back. "See you around, Berna. Try not to fix anything else without me."

I walk back to my pod. I sit in my ergonomic chair. I answer Gloria's call and spend thirty minutes discussing contract amendments and liability caps and the ongoing asbestos situation at the main office.

I do not mention the coffee machine. I do not mention Sam. I do not mention the way our fingers touched when he handed me the seal, or the way he said my name, or the fact that I'm pretty sure I just made a friend, which is inconvenient, because I came here to work, not to make friends.

At noon, a Post-it appears on my monitor.

Yellow. Angular handwriting. Same as before.

*You're incredible. The coffee machine has never worked better. I owe you more than chocolate.*

*Also, I found out the chalkboard quote changes weekly. Next week's is "FAIL FORWARD." I thought you'd want to prepare your sandblasting equipment.*

*, S*

I don't write back.

But I eat the chocolate.

$akm001ch2$,
  3288
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  3,
  'Chapter 3',
  $akm001ch3$
# Chapter 3

The thing about partition walls is that they create an illusion of privacy without actually providing any.

I know this because I'm currently listening to Sam pitch his prototype to someone important, and I can hear every word despite the cork barrier between us, despite my headphones, despite my active attempts to focus on the liability assessment Gloria assigned me this morning.

"The hinge mechanism allows for a full ninety-degree rotation," Sam is saying, "which means the user can adjust the angle without any tools. It's intuitive. You don't need to read a manual. You just,here, try it."

A pause. The sound of something mechanical clicking into place.

"That's... actually very smooth." This voice is different. Older. The kind of voice that's spent decades in boardrooms, evaluating pitches from people who want things. "And the weight distribution?"

"Completely balanced. I spent six months on that alone. The first prototype kept tipping, which is, you know, the opposite of helpful for a mobility device. But this version uses a counterweight system based on,actually, let me show you."

More sounds. Something being adjusted. The investor making an interested noise.

I should not be listening to this. I have work to do. Real work, involving real contracts, with real deadlines that don't care about my neighbor's hinge mechanisms or the way his voice changes when he talks about something he built. There's a confidence in it I haven't heard before. Not the easy charm from the coffee machine disaster. Something more grounded. More certain.

He sounds like someone who knows exactly what he's doing.

This is a workplace. I am a professional. I'm going to stop eavesdropping on my neighbor's investor pitch and focus on indemnification clauses like a normal person.

"The market for this is significant," the boardroom voice is saying. "But the manufacturing costs concern me. You're proposing premium materials at a price point that undercuts the competition. The margins don't,"

"The margins work if we scale. I've modeled it out. At ten thousand units, we break even. At twenty thousand, we're profitable. And the materials aren't negotiable. The foam here is the same grade they use in high-end prosthetics, not the stuff that breaks down after six months and leaves users with pressure sores."

There's something in his voice now. An edge. Not defensive, exactly. Protective.

"And you've tested this? User feedback?"

"Three rounds of testing with the disability advocacy group downtown. They've been incredible. Showed me things I never would have thought of on my own. One of their members, Maria, she's been using the prototype for two months now. Says it's the first assistive device she's had that doesn't make her feel like a patient. That's the whole point. Nobody wants to feel like a patient in their own life."

Something in my chest does something I don't authorize. It's not my business what Sam builds or why he builds it. It's not my business that he apparently collaborates with advocacy groups and remembers individual testers by name. None of this is relevant to my liability assessment, which is due in four hours and currently consists of three bullet points and a growing sense of dread.

I try to refocus on the contract in front of me. Something about indemnification clauses. The words blur.

My phone buzzes. Gloria.

"Berna. Do you have a minute?"

"I have several minutes. I'm surrounded by minutes. They're multiplying."

"That's either very efficient or very concerning and I don't have time to determine which. Listen, I need you to add something to your workload."

"My workload is already a geological formation. You'd need excavation equipment to add anything else."

"It's a small project. Startup liability review. One of our partners is considering an investment and they want us to flag any obvious issues before they proceed."

I close my eyes. I already know what's coming. I don't know how I know, but I know.

"What kind of startup?"

"Assistive technology. Mobility devices. The founder apparently has a prototype that's generating some buzz. Very Portland, very mission-driven, probably completely unprepared for the regulatory landscape they're walking into. FDA considerations, product liability exposure, the usual nightmare scenarios for hardware startups."

"What's the company name?"

"Mobility Kitchen. No, wait," Papers shuffling. "Workshop. Mobility Workshop. The founder is a designer named Sam something. The file's in your inbox."

The partition wall has never felt thinner.

"Berna? You still there?"

"I'm here."

"Is there a problem?"

There are several problems. The most immediate problem is that I'm now professionally obligated to review the liability exposure of the man I've been eavesdropping on for twenty minutes. The second problem is that said man is currently pitching an investor approximately twelve feet from my desk. The third problem is that I can still hear his voice through the wall, and it's doing something inconvenient to my concentration.

"No problem," I say. "I'll review the file."

"Great. Let me know if you find anything catastrophic. The partners want a preliminary assessment by end of week. And Berna? Be thorough. Harrison's putting personal capital into this one. He doesn't like surprises."

She hangs up. I stare at my phone. I stare at the partition wall. Through it, I can hear Sam wrapping up his pitch, the investor making interested noises, the click of the hinge mechanism being demonstrated one more time.

I'm going to be his lawyer.

Not his lawyer, technically. The firm's lawyer, conducting an assessment for the firm's client, who is a potential investor in his company. But the distinction feels thin. Thinner than the wall. Thinner than the excuse I'm constructing for why I'm still listening to his pitch instead of reading my contracts.

The meeting ends. I hear handshakes, goodbyes, the investor's footsteps retreating toward the elevator. Then silence, followed by a long exhale that sounds like relief and exhaustion and hope all tangled together.

A Post-it appears on my monitor.

I didn't see him come around the partition. I was too busy spiraling. But there it is: yellow, angular handwriting, dead center.

*That was the biggest investor I've ever pitched. I think he might actually be interested. I need to scream into a pillow but there are no pillows here so I'm writing you instead.*

*How's your day going?*

*, S*

I write back. I shouldn't, but I do.

*My day just got complicated. Congratulations on the pitch. Try the meditation room on the second floor. There are pillows there. I've been told the energy is very unblocked.*

*, B*

I stick it on his monitor when he's in the bathroom. When I get back to my desk, the file from Gloria is waiting in my inbox.

Mobility Workshop. Founded eighteen months ago. One employee: Sam Reyes, designer and CEO. Product: adjustable mobility aids with "design-forward aesthetics." Current funding: personal savings and a small grant from a disability advocacy nonprofit. Seeking: Series A investment to scale manufacturing.

I open the attachment. It's a mess.

Not a malicious mess. Not a fraudulent mess. The kind of mess that happens when someone who cares deeply about building a good product doesn't have anyone to help them with the paperwork. The liability waivers are incomplete,half of them are missing signature lines entirely. The testing documentation is inconsistent, with dates that jump around and methodology descriptions that vary from one report to the next. There's a safety certification from a lab I've never heard of, which might be legitimate or might be someone's garage with a certificate printer.

The corporate structure is nonexistent. He hasn't filed the right forms for investor capital. His insurance coverage is inadequate for the risk profile. The intellectual property situation is unclear,there's mention of a provisional patent but no evidence it was ever converted to a full filing.

And then there's the CeraTest report.

CeraTest is a materials testing company. They provide certification that the components in a product meet certain durability and safety standards. The report in Sam's file says all his materials passed. But something about it looks... thin. The methodology section is shorter than I'd expect. The sample sizes are smaller than industry standard. The date is from eight months ago, which means he might have changed suppliers since then without getting new certification.

It's probably nothing. It's probably just a small company cutting corners on paperwork because they don't know better, because they're too busy building something they believe in to worry about documentation. But "probably nothing" is not the same as "definitely nothing," and my job is to flag anything that might become something.

I make a note. I highlight the CeraTest section. I keep reading.

At 6:30, my phone buzzes again. Not Gloria this time. Marco.

**Marco:** Emergency. Come to the restaurant.

**Me:** What kind of emergency?

**Marco:** The life-or-death kind. Also I need you to taste something.

**Me:** Those are different levels of emergency.

**Marco:** They're the same level when you're me. Get here. Bring opinions.

Marco's restaurant is a twenty-minute bus ride from the Central Eastside, tucked into a corner of a neighborhood that hasn't been gentrified yet but is eyeing the process with interest. It's called Sazón, which means "seasoning" in Spanish, and it serves food that Marco describes as "what his grandmother would make if she had access to a sous vide machine and no fear of God."

When I arrive, the emergency is immediately apparent: there are boxes everywhere.

"What happened?" I ask, stepping over a stack of what appears to be industrial mixing bowls.

"The supplier sent double. Of everything. I ordered fifty pounds of flour, they sent a hundred. I ordered ten cases of tomatoes, they sent twenty. My walk-in looks like a doomsday prepper's fantasy and I have a food blogger coming tomorrow."

"That's not an emergency. That's an inventory error. Call them and,"

"I tried. Three times. They're closed until Monday. And the blogger is coming tomorrow, Berna. She has forty thousand followers and opinions about plating. I can't have her see my kitchen looking like a warehouse exploded."

He looks genuinely distressed. Marco always looks genuinely distressed; it's his resting state, inherited from his mother along with his cheekbones and his inability to let anything go. But this is a higher frequency of distress than usual.

"What do you need me to do?"

"Help me organize. Taste things. Tell me if the new appetizer is too spicy or not spicy enough. Be a human being in my presence while I slowly lose my mind."

"I can do that."

We spend the next hour moving boxes, reorganizing the walk-in refrigerator, and debating the appropriate heat level for a chipotle crema that Marco insists is "perfectly balanced" and I insist is "committing assault."

"It's not that hot," he says, watching me drink my third glass of water.

"My taste buds are filing a police report."

"Your taste buds are dramatic."

"They learned it from watching you."

The back door opens. Marco's sous chef, a woman named Elena who has worked with him for three years and has the patience required to survive Marco, sticks her head in.

"Marco, someone's here about the delivery mixup."

"Finally. Send them back."

"It's not from the supplier. It's some guy who says he was walking by and noticed you got double-shipped. He wants to know if you need help moving boxes."

Marco and I exchange glances. Portland is friendly, but this is aggressively helpful even by Portland standards.

"Send him back," Marco says. "If he's a serial killer, Berna's a lawyer. She'll handle it."

"That's not how any of this works."

The back door opens wider, and Sam walks in.

For a moment, neither of us speaks. He's wearing a different shirt now,a henley, sleeves pushed up past his elbows,and carrying a canvas bag that appears to contain tools. His hair looks like he's been running his hands through it, which tracks with the exhausted-but-wired energy coming off him. He looks like someone who just finished the most important pitch of his career and then walked fifteen blocks to help strangers with produce.

He looks at me. I look at him. Marco looks at both of us with the expression of a man who has just realized something interesting is happening.

"Berna?"

"Sam."

"You work here?"

"I'm helping a friend. With an emergency. Involving tomatoes."

"I'm Marco," he says, extending his hand. "You know Berna?"

"We're neighbors. At the coworking space." Sam shakes Marco's hand, still looking at me with an expression I can't quite decode. Surprise, maybe. Or something warmer. "I was walking home and I saw the delivery truck leaving and the driver said something about a double shipment, so I thought,I don't know, I thought maybe someone could use a hand. I'm good with logistics. And I had tools in my bag because I always have tools in my bag, which is a personality trait I'm working on accepting."

"You just... offered to help a stranger with boxes?"

"I like helping people." He says it simply, without embarrassment. "Also, I've been sitting all day and I needed to move. Seemed like a good solution to both problems."

Marco is looking at me now. The look says many things, all of them inappropriate to address in front of a witness.

"Well," Marco says, "we could definitely use another set of hands. The tomatoes aren't going to organize themselves."

For the next forty-five minutes, Sam helps us reorganize the kitchen. He's good at it,efficient in a way that suggests he's spent time thinking about how spaces work, how objects flow from one place to another. He asks questions about the kitchen layout, makes suggestions about storage that Marco actually considers instead of dismissing, which is unprecedented.

And I notice things.

I notice the concentration on his face when he's solving a spatial problem, the way his eyes go slightly unfocused like he's running calculations. I notice his hands,capable, certain,stacking boxes in configurations that maximize floor space. I notice the easy way he moves around obstacles, the unconscious grace of someone comfortable in physical work.

I notice that when Marco makes a joke about the tomato situation being "a true Italian tragedy," Sam's whole face transforms, his smile reaching his eyes, crinkling the corners in a way that,

I should not be cataloging the corners of his eyes. I should be thinking about CeraTest methodology sections and inadequate insurance coverage.

"Earth to Berna." Marco is waving a hand in front of my face. "Chipotle crema. Final verdict."

"Too spicy."

"You said that an hour ago."

"I stand by my assessment."

Marco sighs. Sam smiles. I pretend I'm not aware of every time our shoulders nearly touch in the narrow aisle between the prep station and the walk-in.

When the kitchen is finally organized, Marco insists on sending Sam home with food. "You helped. You get fed. House rules."

"I can't accept,"

"It's not negotiable. Berna, tell him it's not negotiable."

"It's not negotiable," I say. "Marco will actually follow you home and leave food on your doorstep. He's done it before."

"To who?"

"To me. For two months after I passed the bar. I had so much arroz con pollo I had to buy a second freezer."

Sam takes the container. Our fingers don't touch this time. I notice.

"Thank you," he says, to both of us but looking at me. "For letting me help. And for the food. And for," He stops, recalibrates. "Just thank you."

"Thank you for moving the tomatoes," Marco says. "Very neighborly of you."

Sam leaves. Marco waits approximately four seconds before turning to me with the expression of a man who has just won something.

"Don't," I say.

"I didn't say anything."

"You're about to."

"He carried boxes, Berna. He walked in off the street and carried boxes for strangers. And he kept looking at you when he thought you weren't looking."

"He was looking at the kitchen. It's a nice kitchen."

"He was looking at you rearranging tomatoes like it was the most interesting thing he'd ever seen. I know what I saw."

"What you saw was a neighbor being neighborly. It's a Portland thing. People here help each other. It's exhausting but apparently mandatory."

"People here passive-aggressively correct your recycling habits. That," Marco points at the door Sam just walked through. "That was a man who wanted to be in the same room as you and invented a reason to do it."

I think about the coffee machine. I think about the chocolate. I think about the Post-it notes, still in my desk drawer, evidence of something I haven't named.

"He's a client," I say.

"He's a guy who moved tomatoes."

"His company. It's a potential investment for one of our partners. I'm doing the liability review."

Marco's expression shifts. "Oh."

"Yeah."

"That's complicated."

"I'm aware."

He hands me a container of chipotle crema. "Take this. It's not too spicy."

"It's definitely too spicy."

"Take it anyway. And Berna?" He waits until I'm looking at him. "Just because something's complicated doesn't mean it's wrong. Sometimes it just means you have to be more careful."

I take the bus home. I eat Marco's food, which is too spicy but also delicious. I open the Mobility Workshop file again. I highlight the CeraTest report. I draft three questions I'll need answered before I can complete the assessment.

The file doesn't mention that Sam walks fifteen blocks to help strangers with delivery emergencies. The file doesn't mention his smile or his competence or the way he talks about the people who use his products. The file only contains what can be documented: dates, certifications, corporate structures, gaps in paperwork.

My job is the gaps. My job is always the gaps. The things people forget to document, the corners they cut, the risks they don't see because they're too close to what they're building.

The CeraTest report sits open on my screen until midnight. The methodology section is still too short. The sample sizes are still too small. And somewhere across the city, Sam is probably eating my brother's food and not knowing that I'm about to write a report that could determine whether his dream gets funded.

That's the job. That's always been the job. Find the risks. Name them. Let other people decide what to do about it.

I close the laptop. I go to bed.

I don't dream about anything.

Or if I do, I don't remember it in the morning. Which is functionally the same thing.

Which is what I tell myself, anyway.

$akm001ch3$,
  3088
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  4,
  'Chapter 4',
  $akm001ch4$
# Chapter 4

The liability review begins on a Tuesday, which feels appropriate. Tuesdays are the most bureaucratic day of the week. They lack the momentum of Monday, the hope of Wednesday, the anticipation of Thursday. Tuesdays are for documentation and uncomfortable conversations and sitting in rooms with people whose futures you're professionally obligated to complicate.

I arrive at Mobility Workshop at 9:00 AM. The address Gloria sent is a converted garage in a neighborhood I've never been to, somewhere in Southeast Portland where the streets have names instead of numbers and every third building is either a coffee roaster or a vintage furniture collective.

The garage is... exactly what I expected. Industrial. Unfinished. The kind of space that looks terrible on paper but probably photographs well for brand storytelling. There's a large worktable in the center covered with prototypes at various stages of completion. Tools hang on pegboard walls in arrangements that suggest both organization and obsession. The concrete floor has paint marks in places, evidence of projects past.

Sam is waiting by the door.

"You're here," he says, which is not a greeting but is technically accurate.

"I'm here."

"I mean, I knew you were coming. Gloria emailed me the schedule. But it's different, you being here. In person. In my space." He's wearing a gray t-shirt that fits well and jeans that have actual work stains on them, not the distressed-by-design kind. He smells like coffee and something else, something metallic. Solder, maybe. Or machine oil.

I notice these things because I'm a detail-oriented person. Not for any other reason.

"Should we start?" I ask.

"Right. Yes. Starting." He steps back, gesturing me inside. "I cleaned up. I mean, it's always clean, but I cleaned more. Because you're... evaluating things. It seemed important that the things being evaluated were clean."

"I'm evaluating documents, not floor cleanliness."

"The documents are also clean. Metaphorically." He pauses. "Some of them are actually physical documents, though. I printed things. I wasn't sure if you'd want paper or digital, so I did both. Is that excessive? That feels excessive."

He's nervous. The easy confidence from the investor pitch is gone, replaced by something more uncertain. It should make this easier, having him off-balance. Instead it just makes me aware of the power differential, the fact that I'm here to find problems with something he built with his own hands.

"Paper is fine," I say. "Where should I set up?"

He leads me to a smaller table near the window, where a stack of folders sits next to a laptop and a mug that says "ITERATING UNTIL IT WORKS." The window overlooks a small courtyard where someone has attempted a garden. The attempt appears unsuccessful, but committed.

"I can pull up anything you need," Sam says, hovering near the table like he's not sure if he should sit down or remain standing. "The file structure's a little... organic. I built the company before I knew how companies were supposed to be organized. So things are in weird places sometimes. But I know where everything is. Mostly."

"Let's start with the product liability documentation."

"Sure. Great. That's," He opens the laptop, clicks through several folders. "Here. This is everything from the testing phases. User feedback, safety assessments, the whole,actually, do you want coffee first? I have good coffee now. Not the Forge & Flow war crime. Real coffee. I invested in an actual machine after..." He trails off, color rising slightly in his face. "After the incident."

"After you broke the communal espresso machine."

"After I ambitiously improved the communal espresso machine in a way that temporarily reduced its functionality."

"You flooded the kitchen."

"The flooding was brief."

I almost smile. I catch myself and don't.

"Coffee would be fine," I say. "Thank you."

He makes coffee with the same focused intensity he applies to everything else. I watch him measure grounds precisely, adjust the water temperature, wait for the exact moment to press the plunger. The French press looks new but well-used, the kind of object that gets handled multiple times daily with care.

"You take it black, right?" He's not looking at me, still focused on the coffee. "I noticed. At the office."

"You noticed how I take my coffee."

"I notice things." He pours, hands me a mug. His fingers come close to mine but don't touch. I notice this too. "It's a design thing. Observation. You can't build things for people if you don't pay attention to how they use things."

The coffee is good. Better than good. I don't tell him this.

"Let's look at the testing documentation."

We spend the next two hours going through files. It's exactly as messy as I expected: a mix of formal reports and informal notes, some dated and some not, some signed and some just... there. Sam explains each document as I flag it, his voice shifting into that grounded confidence I heard through the partition wall.

"Maria's feedback was crucial here," he says, pointing to a section of user testing results. "She uses a manual wheelchair and she told me the original grip angle was wrong. I thought it was fine because I'd tested it on myself, but I don't actually use mobility aids daily. I couldn't feel what she felt."

"You tested on yourself?"

"Of course. How else would I know if something works?"

"By having qualified testers. Following established protocols."

"I did that too. Eventually. After I'd built something worth testing." He leans back in his chair, running a hand through his hair in a gesture that reads as unconscious, habitual. "Look, I know the documentation is a mess. I know there are gaps. I was building something that mattered, and the paperwork felt less urgent than getting the product right. Which is probably exactly what every founder says before their company gets sued into oblivion."

"It's exactly what every founder says, yes."

"Is this where you tell me I'm doomed?"

"This is where I tell you that you have work to do. The gaps aren't unfixable, but they need to be fixed. Especially the safety certifications."

His expression shifts. Something tightens around his eyes. "The CeraTest report."

"You know it's insufficient."

"I know it's what I could afford eight months ago. They're a smaller lab, but they're legitimate. I checked. I wouldn't put something in people's hands if I didn't think it was safe."

"I believe that. But believing something is safe and proving something is safe are different legal categories. Your investors are going to want proof. More importantly, if something ever goes wrong, a judge is going to want proof. This," I tap the report. "This is thin."

He doesn't argue. He just nods, slow and reluctant.

"What would I need?"

"A more comprehensive assessment. Larger sample sizes. Standardized methodology. It's not cheap, but it's necessary."

"How not cheap?"

"Twenty to thirty thousand, depending on scope."

The number lands like a physical weight. I watch him absorb it, watch the calculation happening behind his eyes: budget versus timeline versus everything else he's trying to hold together.

"Okay," he says finally. "Okay. I'll figure it out."

"There's also the matter of your corporate structure."

"My corporate structure is just me."

"Exactly."

We go through more documents. I flag the incomplete liability waivers, the missing IP documentation, the insurance coverage that won't protect him if someone gets hurt. With each item, he listens carefully, takes notes in a small notebook with handwriting I can't quite read, asks questions that suggest he's actually processing the information rather than just waiting for me to finish.

At noon, my stomach growls. Audibly. Embarrassingly.

"Lunch," Sam says, standing up before I can pretend it didn't happen. "There's a place two blocks over that does incredible banh mi. My treat. Consider it part of the liability review experience."

"I don't think lunch is standard protocol."

"Nothing about this is standard protocol. You're my neighbor and also potentially the person who decides whether my company survives the due diligence process. We're so far outside standard protocol that standard protocol is a dot on the horizon."

He's not wrong.

We walk to the banh mi place. It's cold outside, a Portland February afternoon with that specific damp chill that gets into your bones. Sam walks slightly faster than me, then notices and slows down. He does this twice before matching his pace to mine, like he's learning a rhythm.

"Can I ask you something?" he says, not looking at me, watching the sidewalk instead.

"You can ask."

"Why law? Corporate liability specifically. It seems like a field designed to make people paranoid about everything."

"That's accurate."

"So why?"

The honest answer is complicated. The honest answer involves student loans and family expectations and the particular kind of security that comes from being paid to anticipate disaster. I don't give him the honest answer.

"I'm good at finding problems. It seemed efficient to make that a career."

"That's the saddest reason to choose a profession I've ever heard."

"It's practical."

"Practical and sad aren't mutually exclusive." He's looking at me now, something careful in his expression. "You could be good at finding problems in a lot of contexts. Detective. Quality control inspector. Restaurant critic. Why the one that involves telling people their dreams have liability exposure?"

"Someone has to."

"That's not an answer."

"It's the answer I'm giving."

He accepts this. We walk the rest of the block in silence that should be uncomfortable but isn't.

The banh mi place is tiny and crowded and smells incredible. We order at a counter staffed by a woman who greets Sam by name and asks about "the prototype." Apparently he's a regular. Apparently everyone in Portland knows about his prototype.

We eat standing at a narrow counter by the window, shoulders nearly touching because there's nowhere else to stand. The bread crunches. The pork is tender. I'm aware of his arm next to mine, the way he takes up space without seeming to notice he's doing it.

"Tell me about the investor pitch," I say, because the silence is becoming something else and I need to redirect it. "Harrison. How did it go?"

"You heard part of it. Through the wall."

"I heard all of it. The partition isn't soundproof."

He groans, tipping his head back. "Of course you did. Of course you heard me rambling about hinge mechanisms to a man who could fund my entire company."

"You weren't rambling. You were," I stop, reconsider. "You were confident. You knew what you were talking about."

"Was that a compliment?"

"It was an observation."

"From you, that might be the same thing."

We finish lunch. We walk back to the garage. The afternoon review continues: more documents, more gaps, more questions. By 4:00 PM, I've filled six pages of notes with issues that need addressing. Sam has consumed three more cups of coffee and developed a slight twitch in his left eye that suggests he's approaching some kind of caffeine-related breaking point.

"I think that's enough for today," I say, closing my laptop.

"Is it? Because I feel like there are probably more ways my company is catastrophically unprepared that you haven't told me about yet."

"There are. But they can wait until Thursday."

He exhales, long and slow, and for a moment he looks exhausted. Not the good kind of exhausted that comes from meaningful work. The kind that comes from realizing how much stands between where you are and where you need to be.

"I know this is your job," he says. "Finding the problems. Naming them. I know you're not doing this to be cruel. But it's," He breaks off, shakes his head. "Never mind."

"It's what?"

"Hard. Hearing someone list everything you did wrong. Even when you need to hear it."

Something loosens in my chest. I didn't realize it was tight until it wasn't.

"You didn't do everything wrong," I say. "The product testing with the advocacy group. The way you incorporated user feedback. The attention to materials quality. Those are right. Those are more right than a lot of companies I review. You just built the house before you finished the foundation."

"And now I have to lift the house and build the foundation underneath it."

"That's one metaphor."

"What's a better one?"

"I don't do better metaphors. I do liability assessments."

He almost smiles. I almost smile back. We're standing by the door now, me gathering my bag, him hovering in that uncertain way he has, like he's not sure if the conversation is over or just pausing.

"Thursday," he says. "Same time?"

"Same time."

"I'll make better coffee."

"The coffee was already good."

"See, you can give compliments. I knew it was in there somewhere."

I'm halfway out the door when he speaks again.

"Berna."

I turn. He's silhouetted in the doorway, workshop light behind him, and for a moment he looks like a different person. Someone carrying something heavy and trying not to show it.

"Thank you," he says. "For being honest. For not just telling me what I wanted to hear."

"That's my job."

"I know. But you could do it colder. Some people do it colder."

I don't know what to say to this. I don't know what to do with the way he's looking at me, or the way it makes me feel something I'm not prepared to name.

"Thursday," I say again, and leave before the moment can become anything else.

---

Dev calls that night. This is unusual. Dev texts; Dev does not call. His voice over the phone sounds like the audio version of his face: precise, impatient, optimized for information transfer.

"The investor pitch deadline is in six weeks," he says, without preamble. "Harrison's putting together the formal term sheet. He needs your preliminary assessment by the twenty-eighth."

"I'm aware of the timeline."

"Are you aware that Harrison is betting personal capital on this? Not firm money. His money. He seems to think your neighbor's little wheelchair company is going to be the next big thing in accessible design."

"It's not a wheelchair company. It's mobility aids. Multiple products."

"Whatever. The point is, if your assessment says there are problems, we need to know early. Harrison doesn't like surprises."

"Gloria already told me that."

"Gloria told you the polite version. I'm telling you the actual version. Find the problems now, before Harrison gets more attached. He already likes this guy too much. Something about 'founder energy' and 'mission alignment.' It's making him sloppy."

I think about Sam in the doorway. The weight he was carrying. The way he thanked me for being honest.

"I'm being thorough," I say. "The assessment will be accurate."

"Accurate is good. Fast is better."

He hangs up. I stare at my phone for a long moment. Then I open the Mobility Workshop file again and find the CeraTest report.

The methodology section is still too short. The sample sizes are still too small. But now I'm looking at it differently. Not as a gap to flag, but as a problem with a solution. A problem that costs twenty to thirty thousand dollars that Sam almost certainly doesn't have.

I make a note to look into alternative testing facilities. Lower cost, same standards. It's not my job to solve his problems. It's my job to identify them.

But maybe I can identify some solutions while I'm at it.

---

Thursday is warmer. Or maybe I'm dressed warmer; it's hard to tell. The walk from the bus stop to the garage feels different this time, more familiar. I know which door to use. I know where the garden is. I know that Sam will be waiting with good coffee and nervous energy and questions I'm not entirely prepared to answer.

He's reorganized the workshop. I notice this immediately: the prototypes have been moved, rearranged into what looks like a chronological sequence. Version one, version two, version three. A visual history of iteration.

"I thought you might want to see the progression," Sam says, following my gaze. "For context. It's easier to understand the documentation if you can see what the documentation is about."

"That's... actually helpful."

"Don't sound so surprised. I've been reading about due diligence. Turns out there are entire websites dedicated to helping founders not fail at this."

"You've been reading about due diligence."

"I also watched four YouTube videos and called my college roommate, who works in venture capital and told me I was 'charmingly underprepared.' Direct quote. He seemed concerned but supportive."

We settle at the worktable this time, closer to the prototypes. Sam walks me through each version, explaining what worked and what didn't, how user feedback shaped the changes, why certain decisions were made and unmade and made again.

His hands move when he talks. I notice this now in a way I didn't before. He gestures toward the products as he explains them, touches components to demonstrate how they work, drums his fingers on the table when he's thinking through a complicated point. The hands are capable, sure of themselves in a way his voice sometimes isn't.

"The third version was the breakthrough," he says, picking up a forearm crutch that looks nothing like any forearm crutch I've seen. It's angular, almost sculptural, with a grip that curves in unexpected ways. "Maria,the tester I mentioned,she used this for two weeks and came back with a page of notes. Half of them were things I'd never considered. The angle of the handle at different terrains. The way weight shifts when you're going up stairs versus down. Things that seem obvious once someone tells you, but you can't know them unless you live them."

"You listen to your users."

"They're not users. They're people. They use the products, but that's not... that's not why I listen to them." He sets the crutch down, looks at it rather than at me. "I got into this because of my sister. She has MS. Progressive. She's used about fifteen different mobility aids in the past decade, and every single one of them made her feel like a patient first and a person second. Like she was defined by what she couldn't do instead of what she could. I wanted to make something that felt like hers. Not like medical equipment she borrowed from the universe."

The workshop is quiet. Outside, a car passes. Inside, the overhead lights hum faintly.

"You don't mention your sister in the company materials."

"She asked me not to. She doesn't want to be a story. She just wants to walk to the grocery store without strangers assuming she can't handle a door."

I add this to the list of things I know about Sam Reyes: good coffee, Post-it correspondence, expensive apology chocolate, a sister who doesn't want to be defined by what she can't do.

The list is getting long. I'm not sure when that happened.

"Let's talk about the patent situation," I say, because talking about patents is safer than whatever else we might talk about.

We work through the afternoon. The gaps are still there, but they feel different now. Not like failures, but like problems waiting for solutions. I find myself explaining things more thoroughly than I normally would, offering context that goes beyond the scope of the assessment. Sam takes notes. He asks questions. At one point, he asks me to repeat something and I realize he's recording it on his phone.

"For later," he says. "So I remember."

"You could just read the written assessment."

"Your voice explains it better."

I don't know what to do with that. I focus on the patent documentation and pretend I didn't hear it.

At 5:30, we're still working. The light outside has shifted, turned golden and then amber and is now fading toward dusk. I've lost track of time, which almost never happens.

"I should go," I say, checking my phone. Two texts from Marco. One from Gloria. Nothing urgent, but the day is supposed to be over.

"Or," Sam hesitates. "There's an event tonight. A design showcase thing, at the Ecotrust building. A bunch of local companies presenting work. I'm not presenting, but I was going to go anyway. See what other people are building. Network, probably, although I'm terrible at networking. It's mostly just me standing in corners drinking wine and waiting for conversations to happen."

"Are you inviting me to a design showcase?"

"I'm inviting you to witness my networking failures firsthand. For context. Liability purposes, maybe."

"That's not what liability means."

"I know what liability means. I've been reading about it on websites."

I should say no. I have texts to respond to, dinner to make, work to finish. This is not a professional activity. This is not part of the assessment.

But I'm curious about the corners he stands in. I'm curious about the wine he drinks while waiting for conversations to happen.

"Fine," I say. "But I'm driving myself."

"You have a car?"

"I have access to a car. Marco's."

"Marco. Who makes the spicy crema."

"You remember the spicy crema."

"I ate the spicy crema. It's difficult to forget something that directly confronts your taste buds."

---

The Ecotrust building is glass and exposed timber, the kind of architecture that announces its sustainability credentials through visual aesthetics. The showcase is on the third floor, a large open space filled with tables displaying various design projects. Sustainable packaging. Modular furniture. Bicycles made from reclaimed materials. Very Portland.

Sam is already there when I arrive, standing in a corner exactly as he predicted, holding a glass of wine and looking slightly uncomfortable. He sees me and his expression shifts,relief, maybe, or something adjacent to it.

"You came," he says.

"I said I would."

"People say things."

"I say things I mean."

He hands me a glass of wine without asking what I want. Red. Decent. The corners of the room are starting to fill with other people who presumably also struggle with networking.

"Tell me about the projects," I say. "What should I be looking at?"

He walks me through the room, pointing out things I wouldn't have noticed on my own. The way one furniture designer is solving a problem with modularity. The way another company is approaching packaging sustainability differently than the obvious methods. He sees the decisions behind the objects, the thinking that led to the making.

His voice changes when he talks about design. That grounded confidence from the investor pitch. His shoulders relax. His hands move more freely. He occupies space differently,not taking up more of it, exactly, but claiming what he occupies with more certainty.

We end up near a window, looking at the city lights beginning to appear in the dusk.

"Thank you for coming," he says. "I know it wasn't required."

"Nothing about this evening is required."

"I know. That's why I'm thanking you."

We're standing close. I can smell the coffee on him still, underneath the wine. I can see the place where his hairline meets his temple, the small scar above his eyebrow that I've never noticed before.

"I found some alternative testing facilities," I say, because saying anything is better than standing in silence noticing scars. "For the CeraTest issue. There's a lab in Eugene that does comparable work for about fifteen thousand. Still not cheap, but less catastrophic."

His face does something complicated. "You looked into testing facilities."

"It's relevant to the assessment."

"It's beyond the scope of the assessment."

"My scope is flexible."

"That's," He stops, shakes his head. "You didn't have to do that."

"I know."

"But you did anyway."

"I'm efficient. If there's a solution that addresses the problem I've identified, it seems wasteful not to mention it."

"Efficient," he repeats, like he's testing the word. "Is that what this is?"

"What else would it be?"

He doesn't answer. He's looking at me in a way that makes me want to look away, but I don't. We stand there, in the corner he predicted he'd be standing in, not quite touching, not quite not touching.

My phone buzzes. Marco.

**Marco:** You're at a design thing? With the tomato guy?

**Me:** How do you know that?

**Marco:** I know everything. Also you took my car and you never take my car unless something's happening.

**Me:** Nothing is happening. It's work.

**Marco:** Sure. Work. That's why you're texting me instead of talking to him.

I put my phone away.

"Brother?" Sam asks.

"He's concerned about his car."

"Is his car okay?"

"His car is fine."

"Then why does he seem like he's texting you every four seconds?"

"He's invested in my wellbeing."

"Is your wellbeing in question?"

I look at him. He looks at me. The room is full of people, full of sustainable design projects and reclaimed materials and wine glasses clinking, and none of it seems to exist outside this corner.

"I should go," I say.

"Probably."

"Thursday. The assessment continues."

"Thursday."

I leave. I drive Marco's car home. I don't think about the scar above his eyebrow, or the way he said my name, or the testing facilities I researched that had nothing to do with the official scope of my work.

I don't think about any of it.

The CeraTest report sits open on my laptop until midnight. But now there's a note next to it: Eugene lab, $15K, contact info.

A solution. Not my job to provide, but provided anyway.

$akm001ch4$,
  4243
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  5,
  'Chapter 5',
  $akm001ch5$
# Chapter 5

Powell's smells like old decisions.

I don't know why I think this, standing in the entrance of the Red Room, surrounded by floor-to-ceiling shelves of used books organized by color rather than subject. It's not a logical observation. Books don't smell like decisions. They smell like paper and dust and whatever the last person who touched them was eating.

But there's something about this place that feels like accumulated choices. Every spine on every shelf represents someone deciding to write, someone deciding to publish, someone deciding to sell, someone deciding to buy and then deciding to let go. The room is dense with wanting and releasing.

"You've never been here," Sam says. It's not a question.

"I've been to Powell's. The main building. For reference materials."

"Reference materials." He shakes his head, smiling in a way that makes his profile catch the light. Not laughing at me, exactly. More like delighting in something I've accidentally revealed. "You came to a city block of books and went straight for reference materials."

"They're organized alphabetically. It's efficient."

"The Red Room is organized by color."

"I can see that."

"It's completely impractical for finding anything specific."

"Then why are we here?"

He turns to look at me fully, and something in his posture shifts. The nervous energy from the workshop visits is gone tonight. In its place is something quieter, more settled. Like he's decided something and hasn't told me what.

"Because sometimes you find things you weren't looking for. That's the whole point."

We're not supposed to be here. The assessment is finished,I submitted the preliminary report to Gloria yesterday, twelve pages of documented gaps and recommended solutions. The professional entanglement should be over. Sam is no longer a file on my laptop or a voice through a partition wall or a client whose liability exposure I'm obligated to evaluate.

He's just a person who texted me at 6:30 asking if I wanted to see something beautiful.

*Something beautiful* turned out to be Powell's at night, when the tourists have cleared out and the serious browsers emerge. Sam said he comes here when he needs to think. He said the color-sorted shelves help him see patterns differently.

I said yes because I wanted to see what he meant. That's the reason I told myself.

"What are we looking for?" I ask, following him deeper into the Red Room. The shelves glow amber and crimson under the warm lights, hundreds of spines in varying shades creating something that feels less like organization and more like art.

"Nothing specific." He stops in front of a section that transitions from deep burgundy to pale pink. "That's the rule. You walk until something catches your eye, and then you read the first page. If the first page doesn't work, you put it back. If it does, you keep going."

"That seems inefficient."

"Everything about you is efficiency." He pulls a book from the shelf without looking at the title,rose-colored, small, battered at the corners. His fingers wrap around the spine with the same certainty he brings to everything physical, the kind of grip that suggests he knows exactly how much pressure a thing can hold. "What happens if you stop being efficient for one hour?"

"The world probably doesn't end."

"Probably."

"Fine." I reach for a book at random. Dark red, larger than a paperback, with gold lettering I can't quite read. "What are the stakes?"

"Stakes?"

"If neither of us finds anything on the first page, what happens?"

"We try again. There's no failure condition, Berna. It's not a liability assessment."

The way he says my name. I've heard him say it before,at the workshop, at the design showcase, through the partition wall when he didn't know I was listening. But something is different tonight. The syllables sit in his mouth longer before he releases them. Like he's paying attention to the shape they make.

I open my book. It's poetry. Spanish poetry, which I wasn't expecting. The first page is a dedication: *Para los que esperan sin saber qué esperan.*

For those who wait without knowing what they wait for.

I close it. Put it back.

"First page didn't work?"

"First page worked too well."

He doesn't ask what I mean. He just nods, slow and thoughtful, and something passes between us that I don't have language for. We're standing close in the narrow aisle, closer than two people usually stand when they're just looking at books. The space between us feels warm, charged with something I'm pretending not to notice.

"Bar," he says. "There's a place around the corner. They have whiskey you'd like."

"How do you know what whiskey I'd like?"

"I pay attention."

We walk. The night air is cold enough to sting, February in Portland finally deciding to act like winter. Sam walks beside me, matching my pace without seeming to try. I'm aware of his silhouette in my peripheral vision,the slope of his shoulders, the way he holds himself when he's not nervous. Upright but not rigid. Present in his body in a way I find difficult to replicate.

The bar is called The Wayward. I've walked past it a dozen times and never gone in. It's the kind of place that looks intimidating from outside: low lighting, no visible signage, a door that seems designed to discourage entry. Inside, it's smaller than I expected. Warm. A handful of tables, a long wooden bar, a bartender who nods at Sam like they know each other.

"Two of whatever's interesting," Sam says. "Her preference on temperature."

"Neat," I say. "No ice."

The bartender pours without comment. The glasses that arrive are amber-colored, heavy in the hand. I take a sip and taste smoke and honey and something else I can't identify.

"This is good," I admit.

"I know."

"Confident."

"About whiskey? Always." He takes a sip of his own, leaning against the bar. The low light catches the planes of his face differently than daylight, softer, less defined. "About other things, not so much."

We find a table in the corner. It's too small for two people; our knees nearly touch beneath it. I adjust. He doesn't. I notice this.

"Tell me something," he says. "Something that isn't about work."

"That's a broad request."

"It's supposed to be. You know things about me. My sister. My company. My failure to maintain adequate documentation." He smiles, and it's the smile from Marco's kitchen, the one that reaches places I don't want to catalog. "I know you take your coffee black and you think my chipotle crema is too spicy,"

"Marco's chipotle crema."

",and you read poetry in Spanish but won't tell me why it worked too well. That's not balanced. I need more data."

"What kind of data?"

"The kind you don't put in reports."

The whiskey is warming my throat, loosening something in my chest. I take another sip before answering.

"My father collected books. Not like a hobby,like a compulsion. Every surface in our house was covered. He had this theory that you couldn't understand a person until you'd seen their library. What they kept. What they got rid of. What they never finished."

"What happened to his collection?"

"He died. We donated most of it." I pause. "I kept the poetry. Just the Spanish poetry. He used to read it out loud when I was young, before I understood what any of it meant. I think I kept it because I wanted to understand eventually."

Sam is quiet for a long moment. His eyes stay on my face, steady and serious in a way that makes me want to look away. He's doing the thing he does,the stillness, the complete attention. When he listens, he goes quiet in his whole body. No fidgeting, no checking his phone, no looking around the room. Just eyes and silence and the particular quality of focus that makes me feel seen in ways I'm not sure I'm comfortable with.

"Do you?" he asks. "Understand it now?"

"Some of it. Not all."

"Which parts don't you understand?"

"The parts about waiting."

He doesn't respond to this. He just looks at me, and the look is heavy with something neither of us is naming. The bar is loud around us,music, conversation, glasses clinking,but I can't hear any of it. Just the space between us, getting smaller.

"We should walk," I say. "I need air."

He nods. Pays for the drinks before I can argue. We step outside into the cold, and I breathe deep, letting the night air clear whatever was building in my chest.

We walk. No direction, just movement. Past closed storefronts and lit apartment windows and the occasional other nighttime wanderer. Sam tells me about his sister,not the story he told before, about mobility aids and wanting her to feel like a person, but smaller things. How she used to beat him at chess when they were kids. How she still calls him on Sundays even when she has nothing to say. How her voice sounds different now than it did five years ago, and how he hates that he notices.

"She's getting worse?" I ask.

"MS doesn't have a consistent trajectory. Some years she's fine. Some years she's not." He's looking ahead, at the dark street, at nothing in particular. "Right now she's in a not-fine year. The mobility aids help. The products I'm building help. But I can't fix her, and I hate that I can't fix her, and she hates that I keep trying."

"You fight about it?"

"We have the same fight approximately every three weeks. She tells me to stop treating her like a problem. I tell her I'm not. She says my entire company is evidence that I am. I say I'm helping other people. She says I started it because of her. Neither of us is wrong."

His voice in the dark is different than his voice in the workshop. Lower. Less performative. The kind of voice that comes out when someone stops trying to impress you and just talks.

"That sounds exhausting," I say.

"It is. It's also the most honest relationship in my life. Nobody else calls me on my bullshit the way she does." He glances at me, a sidelong look that catches the light from a passing window. "Until recently."

"I haven't called you on anything."

"You've been professionally obligated to call me on everything for the past three weeks. You found twelve pages worth of things I did wrong and told me about each one in detail."

"That's different."

"Is it?"

I don't answer. We keep walking.

I tell him about Marco. How he decided to be a chef at fourteen and never wavered, not once, not even when our mother said it wasn't a real career. How he showed up at my apartment with food for two months after I passed the bar because he decided I wasn't eating enough and refused to trust me to fix it. How he's the only person I've ever met who cares about things exactly as much as he seems to.

"He sends me recipes," I add. "Every week. Things he's testing, things he wants feedback on. I never cook them,I don't really cook,but I read them. Every single one. I like knowing what he's thinking about."

"You love him," Sam says.

"Of course I love him. He's my closest friend."

"No, I mean,you love him without conditions. Without the efficiency thing. You talk about him differently than you talk about everything else."

We've stopped walking. I didn't notice when. We're standing on a street corner I don't recognize, under a streetlight that makes everything look slightly unreal. Sam's face is half in shadow, half in light, and he's looking at me like he's seeing something I didn't mean to show.

"I don't know how to do things without conditions," I say. "Marco says it's because I'm scared."

"Of what?"

"He has theories. I don't ask."

"What do you think?"

The question sits in the cold air between us. I don't have an answer. Or I do, but the answer is too close to the surface tonight, too easy to reach with whiskey in my blood and his attention on my face.

"I think I'm good at protecting myself," I say finally. "And sometimes being good at something is the same as being trapped by it."

Sam doesn't respond. He just looks at me, and then his hand moves.

It's not fast. Nothing about it is fast. He lifts his hand slowly, deliberately, the way you might reach for something fragile on a high shelf. His fingers come close to my face,not touching, not quite, but close enough that I can feel the warmth of his skin in the cold air. Three inches from my cheek. Maybe less.

He's going to touch me.

I know it with a certainty that feels physical, that settles into my body like a held breath. He's going to touch my face, and I'm going to let him, and something is going to change that can't be unchanged.

But he doesn't.

His hand stops. Holds. The three inches between his fingers and my skin become the entire width of the world. I can see the decision happening in his eyes,the want and the hesitation and the calculation of whether this is allowed, whether I want it, whether he has the right.

The streetlight flickers. Somewhere behind us, a car passes.

His hand drops.

"I should walk you home," he says, and his voice is different now. Rougher at the edges. Like something scraped against it on the way out.

"Sam,"

"It's late. You're cold." He's not looking at me anymore. He's looking at the ground, at his hands, at anything else. "Let me walk you home."

We don't talk about it. We walk side by side with more space between us than before, a deliberate gap that wasn't there an hour ago. The three inches have become three feet, and I feel the distance like a bruise forming.

He's different now. Something closed in him when his hand dropped,some door that was briefly open. His shoulders are tighter. His jaw is set in a way I haven't seen before. He looks like someone who's just made himself stop doing something he wanted to do, and is angry about the stoppage.

I want to say something. I want to tell him it's okay, that I saw the lift and I saw the stop and I understand both. But understanding isn't the same as resolving, and I don't know what resolution would look like here. I don't know what I want it to look like.

That's a lie. I know exactly what I want. I'm just not ready to want it out loud.

At my building, he stops on the sidewalk. Doesn't come up the steps.

"Thank you," he says. "For tonight. For telling me things."

"Thank you for Powell's. And the whiskey."

"Thursday," he starts, and then stops. "I mean,we don't have Thursday anymore. The assessment is done."

"I know."

"So I don't know when," He breaks off, runs a hand through his hair. The gesture is frustrated, almost angry. His body is doing things his voice is trying to hide. "I don't know what comes next."

"Neither do I."

He looks at me then. Really looks, the way he was looking before his hand moved and then stopped moving. The streetlight here is different, steadier, and I can see everything in his face,the want, the retreat, the specific kind of hurt that comes from denying yourself something you were about to have.

"Goodnight, Berna," he says.

"Goodnight."

He walks away. I watch him go until he turns the corner and disappears. Then I stand on my steps in the cold, not going inside, not doing anything except feeling the ghost of warmth where his hand almost was.

Three inches. That's all it would have taken.

Three inches and everything would be different.

I go inside. I make tea I don't drink. I sit on my couch with my father's poetry books and don't read them. My phone stays dark on the table,no texts from Sam, no texts from anyone.

At eleven, Marco calls.

"You're home?"

"I'm home."

"How was the thing? The not-a-date thing with the tomato mobility aid guy?"

"His name is Sam."

"I know his name. You've said it four times in two weeks, which for you is basically a declaration of marriage. How was it?"

I think about Powell's. I think about whiskey. I think about the three inches and the warmth I could feel without touching and the way his voice changed when his hand dropped.

"Complicated," I say.

"Good complicated or bad complicated?"

"I don't know yet."

Marco is quiet for a moment. This is unusual for him. Marco fills silences the way water fills containers,automatically, completely.

"Berna," he says finally. "Did something almost happen?"

"Something always almost happens. That's what almost means."

"Don't be clever with me. I can hear it in your voice. Something almost happened and now you're sitting alone in your apartment making tea you're not going to drink."

I look at the untouched mug on my coffee table.

"I hate that you know me this well."

"I love that I know you this well. It's my only advantage as your oldest friend." He sighs. "Look. I don't know what almost happened. But I know you, and I know that you spend a lot of time not letting things happen. So if something almost happened tonight and you're not sure how you feel about it, maybe the question isn't how you feel. Maybe the question is what you want."

"Those are the same question."

"No they're not. How you feel is about the past. What you want is about the future. You can feel scared and still want something. You can feel uncertain and still know what you're hoping for."

At midnight, I open the book I should have kept from Powell's. Not literally,I didn't take it. But I can still see the dedication in my mind: *Para los que esperan sin saber qué esperan.*

For those who wait without knowing what they wait for.

$akm001ch5$,
  3040
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  6,
  'Chapter 6',
  $akm001ch6$
# Chapter 6

The text comes on Saturday.

I'm at Marco's, watching him prep for dinner service, stealing olives from a small bowl he keeps refilling because he knows I'll steal them. My phone buzzes on the steel counter.

**Sam:** I need to talk to you. Can you meet me?

I stare at it. Three weeks of silence,not complete silence, not hostile silence, but the careful kind. The kind where you reply to practical questions with practical answers and don't acknowledge that anything happened. The assessment was filed. Gloria sent her summary. Harrison is still deciding. We've been professionally complete and personally suspended.

And now this.

**Me:** When?

**Sam:** Tonight. 7. The workshop.

"That's a look," Marco says, without turning from his cutting board. "That's the tomato guy look."

"I don't have a look."

"You have several looks, and that one specifically is the look you make when you're about to do something you've been thinking about doing for three weeks and pretending you haven't."

"That's very specific."

"I pay attention." He scrapes diced onion into a pan, the sizzle filling the kitchen. "What did he say?"

"Just that he wants to meet. Tonight."

"And you're considering not going?"

"I'm considering the professional implications of,"

"Berna." He finally turns, wooden spoon pointed at me like an accusation. "You've been eating my olives for two hours. You've been coming here every Saturday for three weeks. You sit in that same spot and steal my mise en place and pretend you're watching me cook, but what you're actually doing is waiting for something to happen." He turns back to the stove. "Something is happening. Go."

I reach for another olive. He slaps my hand away without looking.

"Those are for the tapenade."

"You have an entire container."

"I have a prep list and forty covers tonight and a friend who eats my inventory while pining over a man she won't admit she's pining over." He slides the onions around the pan. "You're wearing lipstick, by the way. You never wear lipstick on Saturdays."

I touch my mouth without thinking. He's right. I put it on this morning without thinking about why.

"That doesn't mean anything."

"It means you were hoping something would happen today. And now it's happening." He gestures toward the door with his spoon. "Go. I'll save you some tapenade."

I take one more olive on my way out,a victory, small but satisfying. He pretends not to notice.

---

The workshop looks different at night.

I've only ever been here during the day, with light coming through the windows and the whole space feeling open and functional. Now it's dark outside, and the interior lighting creates pockets of shadow between the work areas. The prototypes on the table look less like products and more like sculptures. The pegboard walls with their hanging tools look almost ceremonial.

I stand outside for a moment before going in. The building is old brick, some kind of converted warehouse space, and at night the red brick looks almost black. There are lights on in the windows,I can see the warm glow from where I'm standing on the sidewalk. My heart is doing something inconvenient. Something that belongs to someone younger, someone who hasn't learned that wanting things makes you vulnerable.

A couple walks past, laughing about something. They don't notice me standing here, frozen in front of a door I've walked through a dozen times. It's just a door. It's just a workshop. It's just Sam.

Except it's not just anything.

I check my phone. 6:58. Two minutes early. I could wait. I could give myself two more minutes of not knowing what this is about.

Instead, I push open the door.

The workshop smells different at night too, or maybe I'm just paying more attention. Sawdust and metal and something else,coffee, old coffee, the kind that's been sitting in a pot too long. The heating system clicks and hums. My boots echo on the concrete floor as I walk toward the main work area.

Sam is standing by the main worktable. He's wearing a dark sweater I haven't seen before, sleeves at his wrists for once instead of pushed up. There's something coiled about him tonight, something restless. He's not pacing, but he looks like he wants to.

"You came," he says.

"You asked."

"I wasn't sure you would. After," He stops, shakes his head. "After the silence."

"The silence was mutual."

"Was it?" He crosses his arms, uncrosses them, moves to the edge of the table and leans against it. His body is doing that thing again, the thing it did on the street corner. Like it knows what it wants and is waiting for permission his mind hasn't granted. "I've been replaying that night. The street. The almost."

"Sam,"

"Let me finish." His voice is quiet but firm. "I've been replaying it because I need you to understand something. When I stopped,when I didn't touch you,it wasn't because I didn't want to. It was because I couldn't figure out if you wanted me to. And I couldn't risk being wrong."

The workshop is warm. The heating system hums. Outside, the February evening presses against the windows like it's trying to get in.

"Why does that require meeting tonight?" I ask.

"Because I heard from Harrison."

Something cold moves through my chest. "And?"

"And he's still deciding. He has concerns about the testing documentation,the gaps you identified. He wants to see the new CeraTest results before he commits." Sam pushes off from the table, moves toward the window, turns back. "Which means we're still connected. Professionally. For at least another six weeks."

"I know. Gloria copied me on the timeline update."

"Then you know what that means."

I do. I've been thinking about it since the email came, since I saw the extended timeline and felt relief and disappointment in equal measure. More time. More entanglement. More reasons to keep the three inches where they were.

"It means the professional relationship is ongoing," I say. "It means any," I search for the right word. ",complication would be problematic."

"Problematic." He almost laughs, but there's no humor in it. "That's one word for it."

"What word would you use?"

"Impossible. Frustrating. The kind of situation where you know exactly what you want and can't have it because the timing is catastrophically wrong."

He's closer now. I didn't see him move, but suddenly the space between us is less than it was. Not three inches,more like three feet,but closing.

"Sam, I can't,"

"I know." His voice drops. "I know you can't. I know we can't. Harrison is still evaluating. You're still technically part of the assessment process, even if the main work is done. If anything happened between us and it came out later, it would compromise everything. Your professional reputation. The investment. The whole,"

"Then why did you ask me here?"

The question lands between us. He doesn't answer immediately. Instead, he looks at me with the same intensity from the street corner, the same want and hesitation, except now the hesitation looks more like pain.

"Because I'm not good at pretending," he says. "Because three weeks of silence is eating me alive and I needed to see you and know that you're real and this is real and I didn't imagine,"

"You didn't imagine it."

",the thing that happened. The almost."

"You didn't imagine it."

He exhales. His shoulders drop a fraction. "Okay. Okay. So we're both aware that something is,"

"Something is there. Yes."

"And we both know we can't act on it."

"Not while Harrison's decision is pending. Not while there's any professional connection."

"That could be months."

"I know."

"Months of knowing and not acting and pretending every time we run into each other at Forge & Flow that I'm not thinking about the way you looked under that streetlight."

"Sam."

"I'm just stating facts. You're a lawyer. You like facts."

He's closer again. I still didn't see him move. The three feet are two feet now, maybe less. Close enough that I can see the specific way his jaw is set, the tension in his neck, the place where his collar meets his skin. I catalog these things because cataloging is what I do. I notice details. That's the explanation.

I'm aware of him in a way that feels almost dangerous. The width of his shoulders in that dark sweater. The way his hands hang at his sides, fingers slightly curled. His breathing, which isn't quite steady anymore. Mine isn't either. I can feel my pulse in my throat, in my wrists, in places I don't want to name.

He takes another step. The two feet become something less. I should step back. I should maintain the distance that makes conversation possible. Instead I stay where I am, watching him close the gap, feeling the air between us grow thicker with each inch that disappears.

"This is a bad idea," I say.

"I know."

"Coming here, talking about this, standing this close,"

"I know."

",all of it makes it harder, not easier."

"I know." He's not backing away. "Do you want me to stop?"

The question hangs. Yes, I should say. Yes, let's be professional, let's maintain appropriate distance, let's pretend the streetlight never happened and we never stood in Powell's with our knees almost touching and you never said my name like it meant something.

"No," I say instead. "I don't want you to stop."

His breath catches. I hear it,the small hitch, the moment where his body responds before his mind can intervene. His eyes go dark, not with anger but with something else. Something that makes the workshop feel smaller than it is.

"Berna." His voice is low, rough in a new way. Not frustrated this time. Hungry. "If you don't want me to stop, then I need you to tell me what you do want. Because I'm about to do something that neither of us can undo, and I need to know,"

"I want you to touch me."

I say it before I can stop myself. Before the lawyer part of my brain can intervene with objections and caveats and liability concerns. The words come out plain and certain and more honest than anything I've said in weeks.

His hand moves.

This time it doesn't stop.

His fingers touch my face,my jaw, the space below my ear,and the contact is warmer than I expected. I've been cold all day, cold for weeks, and his skin against mine is a shock of heat that moves through me like current.

"Finally," he breathes, and then he's kissing me.

It's not gentle. It's not hesitant. It's the kiss of someone who has been waiting too long and has stopped caring about patience. His mouth is firm against mine, certain, and I taste whiskey,he must have had some before I came, something to steady himself,and underneath that, something that's just him. My hands move without permission, finding the front of his sweater, fisting the dark fabric to pull him closer.

He makes a sound. A low noise in his throat, almost a groan, and it undoes something in me I didn't know was locked. My back hits the worktable and I don't remember moving, don't remember anything except his body against mine and the weight of him pressing me into the wood. His hand is in my hair now, tilting my head back, and the kiss deepens into something that scrambles my syntax entirely.

I think: this is a mistake.

I think: his mouth is the shape of everything I've been avoiding.

I think: I don't think at all, actually.

His other hand finds my hip, spreads warm and solid against the curve of it, and the touch sends heat pooling low in my stomach. I've been kissed before. I know what kissing is. But I don't know what this is,this consuming thing, this erasure of every thought that isn't him. My careful sentences break into fragments. His chest against mine. His breath coming faster. The smell of him, wood and metal and something clean, shampoo maybe, filling my lungs.

"Berna," he says against my mouth, and the word is wrecked. "Tell me to stop. Tell me this is a mistake and we need to,"

"It is a mistake."

"I know."

"We need to stop."

"I know."

Neither of us stops.

His mouth moves to my neck, traces a line from my jaw to my shoulder, and I hear myself make a sound I don't recognize. My fingers are in his hair now,when did that happen?,and the strands are softer than they look, sliding between my knuckles as I pull him closer. His teeth graze my collarbone and I arch into him and the worktable creaks beneath my weight and,

"Wait." I'm the one who says it. My voice sounds like someone else's. "Wait. Sam. Stop."

He stops immediately. His head comes up, his hands release, he steps back so fast he almost stumbles. His chest is heaving. His mouth is swollen from mine. His eyes are half-wild, dark and desperate and trying to recalibrate.

"Sorry," he says. "I'm sorry, I,"

"Don't apologize." I'm still leaning against the table. My legs don't feel reliable. "That's not why I stopped."

"Why did you stop?"

Because I was about to not stop. Because I could feel the trajectory, the place this was going, and it was somewhere I wanted to go but couldn't. Not yet. Not while everything is still tangled.

"Because I don't want this to be a mistake we have to pretend didn't happen."

He's quiet. Breathing hard. His hands are at his sides, clenching and unclenching like they need something to hold and can't find it.

"What do you want it to be?" he asks.

I think about Marco's question. How you feel is about the past. What you want is about the future.

"I want it to be real," I say. "Not stolen. Not something we have to hide because the timing was wrong and we couldn't wait. If we do this," I gesture between us, at the charged air, at our bodies still leaning toward each other even with distance between them. ",I want to do it properly. Without conflicts of interest. Without professional entanglement."

"That could be months."

"I know."

"Months of knowing what this is now. Knowing what we're waiting for."

"Yes."

He laughs, but it's not a frustrated laugh. It's almost relieved. "You're proposing a rule."

"I'm proposing a boundary. A temporary one."

"What's the rule?"

"Nothing happens until Harrison's decision is final. No professional connection, no conflict of interest, no complication. Once the investment closes or doesn't close, once my involvement is officially over,then we can figure out what this is."

"And until then?"

"Until then, we wait. We're careful. We don't pretend this didn't happen, but we don't let it happen again. Not until it can happen right."

He's still breathing hard. His mouth is still dark from my lipstick,I didn't know I was wearing lipstick that transferred, but apparently I was. He looks wrecked and wanting and somehow, impossibly, also tender.

"Okay," he says.

"Okay?"

"Okay. I'll wait." He moves toward me, slow this time, and stops just close enough to take my hand. His fingers wrap around mine, warm and steady. "But I want you to know that I'm going to be insufferable about it. I'm going to think about this kiss every single day and probably every single night and when we run into each other at Forge & Flow I'm going to look at you like I know exactly what you taste like, because I do now, and I'm not sorry."

"That sounds like a problem."

"It sounds like a promise." He brings my hand to his mouth, kisses my knuckles. The gesture is unexpectedly courtly. Old-fashioned. The kind of thing someone does when they're agreeing to terms they hate but are willing to honor anyway. "However long it takes. I'll wait."

I should say something. Something structured and certain, the kind of sentence I build when I need to feel in control. But my syntax is still broken, my thoughts still scattered by his mouth and his hands and the specific shape of his body against mine.

"Goodnight," I say instead.

"Goodnight." He doesn't let go of my hand. "Will you text me when you get home? So I know you're safe?"

"That seems like contact that might be,"

"One text. Just that you got home. That's allowed, right?"

I think about the rule I just made. The boundary I just drew. One text seems small. One text seems like nothing compared to what just happened.

"Fine. One text."

He lets go of my hand. The absence of his touch is immediate and terrible. I walk toward the door, reach it, turn back.

He's standing where I left him, by the worktable, arms at his sides. His face in the workshop light looks younger than usual. Vulnerable. Like someone who just handed something precious to someone else and is waiting to see if they'll drop it.

"Sam," I say.

"Yeah?"

"The kiss wasn't a mistake. The timing might be wrong, but the kiss wasn't."

His face does something complicated,relief, joy, something that might be hope,and then settles into a smile I haven't seen before. Not the charming smile from the investor pitch. Not the nervous smile from the workshop visits. Something new. Something that belongs only to this moment.

"Good," he says. "I'll hold onto that."

I leave before I can undo every rule I just made.

---

The walk home takes twenty minutes. I take the long way without meaning to, or maybe I mean to and don't want to admit it. My body needs the movement. My mind needs the space.

I keep touching my mouth. It's ridiculous,a gesture from some romantic comedy, the woman pressing her fingers to her lips after a kiss, but I can't stop doing it. I can still feel him there. The pressure of his mouth. The way his teeth caught my lower lip at one point, a small sharp shock that made me gasp.

What am I doing.

The question repeats with every step. What am I doing, what am I doing, what am I doing. The professional implications scroll through my mind like a legal brief I didn't ask to read. Conflict of interest. Bias. The appearance of impropriety even if the actual impropriety is contained. Gloria's face if she found out. Harrison's face. My own face in the mirror tomorrow, looking at someone who knows better and did it anyway.

Except.

Except the rule makes it okay. Doesn't it? We're not doing anything more until the professional connection ends. We acknowledged what's there without acting on it further. One kiss. One interrupted kiss. That's not a relationship. That's not a conflict. That's just,

That's just the feeling of his hands on my hips, burning through the memory like a brand.

I text him when I get home.

**Me:** Home.

**Sam:** Good.

**Sam:** For the record, waiting is going to be terrible.

**Me:** I know.

**Sam:** Worth it though.

I stare at my phone for a long time. The screen goes dark. Lights up again.

**Sam:** I can still taste you.

I close my eyes. The workshop floods back,his mouth, his hands, the sound he made when he pulled me close. My body is still warm from it, still holding the memory in my skin and my pulse and the ache low in my stomach.

I should put the phone down. I should shower and go to bed and stop engaging in contact that blurs the line I just drew. Instead I stand in my kitchen, coat still on, staring at those four words.

I can still taste you.

The audacity of it. The intimacy. The way he's not even pretending to play by the rules we just agreed to, not really, because rules about physical contact don't address this,this trespass of words, this way he's already inside my head.

**Me:** That's not helping with the waiting.

**Sam:** I know. Goodnight, Berna.

**Me:** Goodnight.

I don't sleep until 2 AM. When I finally do, I dream about three inches closing.

$akm001ch6$,
  3374
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  7,
  'Chapter 7',
  $akm001ch7$
# Chapter 7

Monday morning, I become a professional.

Not that I wasn't one before. But there's professional and then there's *professional*,the hyper-deliberate version, the one where every movement is planned two steps ahead, where spontaneity is treated as a security threat.

The kiss was Saturday. Today is Monday. Forty hours of not seeing him, not texting him beyond that one transgressive exchange, not thinking about,

Okay, I thought about it. I thought about it while making coffee Sunday morning and while reading case briefs Sunday afternoon and while lying in bed Sunday night staring at my ceiling like a teenager who just discovered hormones. I thought about the sound he made, that low noise in his throat. I thought about my back against the worktable. I thought about "I can still taste you" and the audacity of sending that when we'd just agreed to wait.

But thinking is private. Thinking doesn't count. Thinking happens inside my skull where it can't compromise anything.

Today, at Forge & Flow, I am a partition wall given human form.

I arrive at 8:47,thirteen minutes later than usual, calculated to avoid the 8:30 arrival window that correlates with his. I walk past the chalkboard without registering its inspirational idiocy. I set up my laptop at my usual table, back to the wall, eyes on the door. My coffee is black. My posture is impeccable. My face is arranged into an expression that says "Deadline Work, Do Not Disturb."

At 9:02, he walks in.

I know this because the entire atmosphere of the room shifts. My body knows his footsteps now,that's a thing that apparently happens when you kiss someone against furniture. The rhythm of his walk has been cataloged somewhere in my nervous system, filed under "threats to professional composure."

I don't look up. I'm reading a contract. It's a very interesting contract about liability indemnification clauses. I'm completely absorbed in the liability indemnification clauses.

The footsteps stop at the coffee station. I can hear the particular click of the industrial machine he prefers, the one he once broke and then fixed and then broke again. I am not listening. I'm reading about indemnification.

He walks to a table.

Not my table. A table across the room, near the window. The chair scrapes as he pulls it out. His laptop bag thuds onto the surface. The chair creaks as he settles into it.

I don't look up.

I'm a professional.

My screen displays paragraph 12.3(b) of the Meridian Holdings contract. I have read paragraph 12.3(b) seven times. I still don't know what it says.

---

The problem with not looking is that you become hyperaware of everything else.

At 9:34, he coughs. Once. Dry. It could mean nothing or it could mean he's thinking about Saturday or it could mean he has allergies. I don't know because I'm not looking at him to check for seasonal symptoms.

At 9:51, he gets up for more coffee. I track the sound of his footsteps,heavier now, more deliberate, like he's walking loudly on purpose. Is he walking loudly on purpose? Is that a thing people do? I don't know. I'm reading paragraph 12.3(b).

At 10:14, someone new arrives.

The door opens with its familiar creak and a woman breezes in carrying what appears to be a portable recording setup,ring light, microphone arm, the works. She's mid-forties, silver-streaked hair pulled into a messy topknot, wearing overalls over a vintage band t-shirt. She commandeers the table in the exact center of the room and begins setting up her equipment with the focused efficiency of someone who does this daily.

"Morning, Forge dwellers!" she calls out to no one in particular. "Anybody want to be background ambiance for a podcast about starting your own business? I promise I won't use your names. Probably."

A few regulars wave. She waves back with both hands, creating a brief impression of interpretive dance.

I've seen her before,she rents desk space here three days a week,but I don't know her name. I've never needed to. She's part of the scenery, like the motivational chalkboard and the perpetually empty snack bowl.

Today, though, she looks at me. Then at Sam. Then back at me.

"Oooh," she says, loud enough to carry. "The frost continues. Day three of the cold war?"

My head snaps up before I can stop it. She's grinning at me, perfectly comfortable with having just made a public observation about my personal life.

"Excuse me?"

"You and Hot Prototype Guy." She jerks her thumb toward Sam's table. "I've been watching you two for weeks. First it was the aggressive eye contact across crowded rooms. Then it was the whispered conversations in the corner. Now it's the deliberate avoidance. Classic hostile trajectory."

My mouth opens. Closes. Opens again.

"We don't have a hostile,"

"Oh, you absolutely do. Let me guess." She taps her chin theatrically. "Business dispute? He stole your client? She undercut your pitch?" She's looking between us now, eyes bright with the investigative zeal of someone who has built a career on reading social dynamics. "Wait, no. Intellectual property dispute. He copied your thing. Or she copied his thing. The creative betrayal angle is very 2024."

Sam has looked up. His face is doing something complicated,half alarm, half amusement. "We don't have an intellectual property dispute."

"Then why are you sitting thirty feet apart and refusing to acknowledge each other's existence?" The woman,Podcaster Lady, I'm calling her now,spreads her hands. "I run a show about small business founders. This is literally my job. Reading rooms. And this room is reading as 'bitter rivals who once shared something they now regret.'"

"We're not rivals," I say. "We're not anything."

"Aha! 'Not anything.' That's a very loaded phrase. That's the phrase people use when they're definitely something and don't want to admit it." She points at me with a pen that appeared from nowhere. "You're the lawyer, right? Contract work? Very structured energy. Probably color-codes her files."

"I don't see how my filing system is,"

"And you," She swings the pen toward Sam. ",are the maker guy. Assistive devices. Very earnest. Probably cried at a TED talk about accessibility."

Sam makes a small, wounded noise. "That's unfair. Those talks are very moving."

"See? Rivals with depth. I love it. This is gold." Podcaster Lady finally settles into her chair and begins adjusting her ring light. "I'm Cassandra, by the way. Cassandra Webb. Yes, like the psychic from Spider-Man, no relation, though I do have an unusual talent for seeing things other people miss. Case in point: your whole situation."

"We don't have a situation," I say, too firmly.

"Sure, honey." She winks. "That's what they all say."

She finishes positioning her microphone, then adds, almost as an afterthought: "You know what the funniest part is? You're both doing the exact same thing. Sitting there pretending to work, hyperaware of each other, maintaining this rigid little distance like it means something. The synchronized avoidance. It's almost choreographed." She tilts her head, studying us with open fascination. "Whatever happened between you, it wasn't business. Business disputes don't have this much tension. This is personal."

Neither of us responds. The silence is confirmation enough.

---

The rest of the morning is an exercise in strategic positioning.

Cassandra Webb has claimed the center of the room, which means every sightline now passes through her orbit. She records what sounds like interview snippets, speaks animatedly into her microphone, and occasionally glances between me and Sam with the satisfied expression of a scientist observing an experiment.

I can't avoid Sam entirely,we're in the same room, and the room isn't that big,but I can manage the encounters. I time my coffee runs for when he's seated. I use the restroom during his calls.

This works until 11:30, when Gloria texts.

**Gloria:** My office. 30 minutes. Bring the Vance file and your calendar.

I stare at my phone. Gloria's office is downtown, at the main Hanover & Pryce building. I wasn't expecting a face-to-face today.

**Me:** On my way.

I gather my things with the controlled precision of someone defusing a bomb. Laptop in bag. Files in order. Coffee cup disposed. Every action deliberate, every movement contained.

I'm almost to the door when I hear my name.

"Berna."

His voice. That voice. Low and careful and completely professional, because other people are listening, but there's something underneath it,a roughness that wasn't there before Saturday. A texture.

I stop. Turn. He's standing by his table, ten feet away, hands in his pockets. His posture is different today,stiffer than usual, shoulders held at an angle that suggests effort. He's standing the way people stand when they're preventing themselves from doing something else.

"You dropped this."

He holds up a pen. It's my pen,the silver one my father gave me for passing the bar. It must have rolled out of my bag.

I walk toward him. Close the ten feet. He extends the pen.

Our fingers don't touch. There's at least half an inch of silver barrel between his skin and mine. But the proximity of the exchange,the controlled gap we're both maintaining,is somehow worse than touching would be. The air between our hands has weight. Density. Temperature.

"Thank you," I say.

"You're welcome."

We stand there for half a second too long. His eyes are steady on mine, and I can see the discipline in them,the effort it takes to maintain the distance, to honor the rule we made. He's holding himself back. I can see it in the tension of his forearms, in the set of his jaw.

"Have a good meeting," he says.

"It's Gloria. No meeting with Gloria is good."

A ghost of a smile crosses his face. "You could always tell her you have a conflict of interest."

The double meaning lands. His smile widens fractionally. My composure cracks fractionally. We stand there, cracking at each other, while Cassandra Webb watches from her central table with the delighted attention of someone witnessing exactly the kind of drama she was hoping for.

"Goodbye, Sam."

"Goodbye, Berna."

I leave. I don't look back. Looking back would be unprofessional.

---

Gloria's office is exactly what you'd expect from a senior partner who has spent thirty years optimizing for intimidation: floor-to-ceiling windows overlooking the river, furniture that costs more than my annual rent, and a complete absence of personal photographs or decorations that might suggest she has a life outside this building.

She's behind her desk when I arrive, reviewing something on her tablet with the focused intensity of a hawk scanning for prey.

"Sit," she says without looking up.

I sit.

"The Vance acquisition closes in three weeks. I'm reassigning you to primary on the subsidiary carve-outs. Henley is overwhelmed and you're ahead on your current portfolio."

This is not what I expected. The Vance deal is the biggest transaction the firm has handled this year,a $400 million acquisition with enough complexity to keep a team busy for months.

"I appreciate the confidence, but my calendar,"

"Your calendar includes the Reyes assessment, which is technically complete." Gloria finally looks at me. Her eyes are the color of slate and approximately as warm. "Harrison is still deliberating, but that's his process, not yours. You documented the gaps. You recommended the solutions. Unless something changes significantly, you're background support at most."

"The CeraTest results are still pending. Sam,Mr. Reyes may need guidance on documentation."

"Which any associate can provide." She sets down her tablet. The gesture is deliberate,Gloria does everything deliberately,and when she looks at me, I feel like a deposition witness who's just realized they're being cross-examined.

"You've been spending considerable time at that coworking space. More than the assessment strictly required."

My stomach tightens. I've prepared for this, the same way I prepare for hostile opposing counsel: anticipate the question, have the answer ready, deliver with confidence. "I find the environment productive."

"Productive." Gloria lets the word hang. "I'm sure you do. But Vance is going to require your full attention. Long hours. Evening sessions. No time for coffee shops with inspirational chalkboards."

She knows. She doesn't know specifically,she can't,but she knows something. Gloria has survived three decades of partnership politics by reading people the way Cassandra Webb claims to. She sees patterns. She draws conclusions.

"I understand," I say.

"I hope you do. Your trajectory at this firm has been exemplary. Partner track by thirty-five if you stay focused. But focus requires discipline. Discipline requires clarity." She picks up her tablet again, dismissal in the gesture. "Clear your schedule. First Vance meeting is tomorrow at eight. Harrison's final call will come when it comes. Let other people worry about it."

"Yes, Gloria."

"Good. Close the door on your way out."

I stand. My legs feel strange,heavy in a way that has nothing to do with walking. At the threshold, I pause.

"Gloria,"

She glances up, one eyebrow raised in a question that's also a warning. Behind her, the river moves gray and indifferent past the windows. A barge slides by, carrying something industrial. The world outside this office continues without caring about partner tracks or professional boundaries or the specific shape of a man's hands.

"Thank you for the opportunity." The words come out steady, professional. Exactly what she expects to hear.

"Make sure I don't regret it."

The door clicks shut behind me. In the elevator, I catch my reflection in the polished steel,composed, competent, not at all like someone whose careful architecture is crumbling from the inside.

---

I don't go back to Forge & Flow.

I can't. Not with Gloria's words echoing in my head, not with the knowledge that my time there is now officially scrutinized. Partner track by thirty-five,that's the carrot she dangles, and I've been chasing it so long I've forgotten what it tastes like. What any of this tastes like. I became a lawyer because I wanted to be good at something that mattered, and somewhere along the way "good at something" became the only thing that mattered. I take my laptop to a coffee shop three blocks away, order a tea I don't want, and sit in a corner booth trying to read about the Vance subsidiary structure while my brain replays the pen exchange on a continuous loop.

Half an inch of silver barrel. Less than a thumb's width. Less than the margin I'd leave handing a stranger their change.

It felt like standing at the edge of a cliff.

The rule is torture. I made it,I specifically and deliberately made it, with logic and good reasons,and now it's eating me alive. Every near-miss is a wound.

And then Sam happened. Sam with his broken coffee machines and his Post-it responses and his hands that build things for people who need them.

My phone buzzes. Not Sam,I almost wish it were Sam, which is itself a problem.

**Marco:** You left Gloria's building looking like someone killed your dog. Drink?

**Me:** How do you know what building I left?

**Marco:** I have spies. Also Pedro from the bakery saw you. His exact words were "your sister looked like she was attending her own funeral."

**Me:** Dramatic.

**Marco:** That's what I said. Then he pointed out that you were holding your briefcase like a weapon, walking at funeral pace, and didn't even look at the croissant display. So. Drink?

I stare at the message. Marco always knows. It's annoying and comforting in equal measure.

**Me:** Can't. Working on a new assignment. Rain check?

**Marco:** This is you ducking the conversation about the tomato guy, isn't it?

**Me:** His name is Sam.

**Marco:** I KNOW. You keep telling me. Which tells me everything. Rain check accepted but I expect a full debrief eventually.

**Marco:** P.S. His name being important enough to correct = you're already in trouble, hermanita.

I put the phone down. Pick it up. Put it down again. Marco has this infuriating ability to summarize in a sentence what I've spent forty hours failing to articulate to myself. Trouble. That's exactly what this is.

The tea grows cold. The subsidiary documents blur. Somewhere across the city, Sam is probably still at Forge & Flow, thirty-seven feet from where I usually sit, wondering why I didn't come back.

I think about texting him. Just something professional. Just a quick note that Gloria reassigned me, that I won't be at Forge & Flow as much, that the situation has become more complicated than it already was.

But that's contact. That's connection. That's exactly what we're not supposed to be doing until the professional entanglement ends.

I close my eyes. I can still feel the pen in my hand,the weight of it, the faint pressure of his proximity.

The rule exists for good reasons. I believe in the reasons. But believing in a rule and living it are different things. Living it means sitting in a coffee shop three blocks away from where I want to be, holding a cold tea I never wanted, pretending I can work while my body remembers the specific pressure of his mouth against mine.

I make myself read one more paragraph about subsidiary structures.

Then another.

Then another.

This is fine. I'm fine. This is just a temporary adjustment period.

Eventually the gap won't feel like drowning.

Eventually.

---

That night, at 11:47, my phone lights up.

**Sam:** Cassandra thinks we're business rivals who had a falling out over intellectual property. She spent an hour explaining her theory to me after you left.

I shouldn't respond. It's nearly midnight. Professional boundaries don't include midnight texting.

But I'm already typing.

**Me:** What did you tell her?

**Sam:** That it was much worse than intellectual property. That you stole my heart's patent and I'm suing for emotional damages.

I stare at my screen. The audacity of this man.

**Me:** That's not funny.

**Sam:** It's a little funny.

**Sam:** She believed me, by the way. She's planning to do an episode about creative breakups. I may have accidentally started something.

**Me:** You definitely started something.

Three dots appear. Disappear. Appear again.

**Sam:** I know.

**Sam:** Goodnight, Berna.

I should stop here. I should put down the phone and remember that this is exactly the kind of contact that erodes the rule.

**Me:** Goodnight, Sam.

I don't sleep until 2 AM.

When I do, I dream about a silver pen and a voice that says "I know" like it's both a confession and a promise. I dream about Gloria's slate-gray eyes, Cassandra's knowing grin, and an ocean I'm not allowed to cross.

$akm001ch7$,
  3088
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  8,
  'Chapter 8',
  $akm001ch8$
# Chapter 8

The Vance subsidiary documents are surprisingly boring.

I know that sounds like something a lawyer shouldn't admit, even silently, but after three days buried in carve-out provisions and asset allocation schedules, I've developed a new appreciation for how paperwork can function as a sedative. Every paragraph is designed to prevent interesting things from happening. Every clause exists to define the exact boundaries of what constitutes a surprise.

I miss surprises. I miss a certain kind of surprise, specifically,the kind that arrives via Post-it note or text message or the accidental brush of fingers against silver pen barrels.

Gloria's corner office is visible from my temporary desk on the twenty-third floor of the main Hanover & Pryce building. She walks past the glass wall every forty-five minutes like clockwork, never looking in my direction, never acknowledging my presence. But I feel watched anyway. Monitored. Like I'm being assessed on metrics I don't fully understand.

My phone buzzes. I don't look at it.

I last eight seconds.

**Sam:** How's corporate purgatory?

**Me:** Educational. I've learned that asset allocation can be done in seventeen different ways, all of which are terrible.

**Sam:** That sounds like something you'd hate.

**Me:** I don't hate it. I find it professionally rewarding.

**Sam:** Berna.

**Me:** Fine. I hate it. I hate it with a passion that would alarm my mentor if she knew.

**Sam:** There she is.

I'm smiling at my phone like an idiot. In Gloria's line of sight. Where she could walk by at any moment and see exactly what kind of distraction I'm allowing into my allegedly focused workday.

**Me:** How's Forge & Flow?

**Sam:** Cassandra has a new theory. She thinks we had a torrid affair that ended badly and now I'm pining while you've moved on to "corporate conquest."

**Me:** That's impressively wrong.

**Sam:** She's interviewing regulars about it. For content.

**Me:** She's WHAT

**Sam:** Relax. Nobody knows anything. They're all just making things up. Though the barista did suggest we might be secret siblings separated at birth.

**Me:** That's horrifying.

**Sam:** I told him our family trees are geographically incompatible. He seemed disappointed.

I put my phone face-down on my desk and stare at the Vance documents without seeing them. Three days. It's been three days since the pen exchange, three days since midnight texts about hearts and patents, three days since I walked out of Forge & Flow knowing I wouldn't be back for a while.

The rule is holding. Technically. We text, but texting isn't prohibited,texting is just words on a screen, safe and distant and completely under control. I can feel the pull of him through my phone, but I can resist it. I'm good at resisting things.

I've been good at it my whole life.

My phone buzzes again.

**Sam:** Harrison called this morning.

I pick up the phone faster than I'd like to admit.

**Me:** And?

**Sam:** He's flying out next week. Wants to see the new CeraTest results in person before making his final decision.

**Me:** That's good, right? Shows he's serious.

**Sam:** It would be. Except Dev is coming with him.

Dev. The name lands in my chest like a small, cold stone. Dev Chen, Harrison's junior partner,I've never met him, but I've read his reputation. Brilliant. Ruthless. The kind of investor who treats due diligence like a blood sport.

**Me:** Nervous?

**Sam:** About Dev? Always. About the results? A little. I've been looking at the CeraTest methodology docs you flagged, and... I don't know. Something feels off.

I sit up straighter. The Vance documents suddenly seem very far away.

**Me:** Off how?

**Sam:** I can't explain it. The numbers look fine. The graphs are pretty. But when I try to trace the testing protocols back to the original calibration data, there are gaps. Missing timestamps. Like someone reconstructed the sequence after the fact.

**Me:** That's... concerning.

**Sam:** Probably nothing. I'm probably just paranoid because Dev makes everyone paranoid.

**Me:** Or you're noticing something real. Your instincts are usually good.

**Sam:** Usually?

**Me:** I'm a lawyer. I hedge.

**Sam:** And here I thought you were just constitutionally incapable of unqualified praise.

**Me:** That too.

I'm grinning at my phone again. Gloria walks past her glass wall, and I force my face into something neutral and professional. She doesn't look at me, but I feel the weight of her attention anyway,the sense that every choice I make is being cataloged somewhere for future reference.

**Sam:** I should go. Cassandra is setting up her equipment and she keeps gesturing at me in ways that suggest she wants a quote.

**Me:** Don't give her one.

**Sam:** I would never.

**Sam:** Though she did offer to make me the subject of an episode called "The Maker and the Muse" which has a certain ring to it.

**Me:** I'm not your muse.

**Sam:** I know.

**Sam:** You're much more dangerous than that.

I stare at the message. My chest does something inconvenient,a tightening that has no place in a professional environment.

**Me:** Go deal with Cassandra.

**Sam:** Going.

**Sam:** Text me later?

**Me:** Maybe.

**Sam:** I'll take maybe.

I put the phone away and return to the subsidiary documents, but the words swim on the page. Missing timestamps. Gaps in calibration data. Sam's instincts aligning with my own suspicion that something in the CeraTest methodology doesn't add up.

I open my laptop and pull up the original liability review I did for Mobility Workshop. Somewhere in those files, there are notes I made about the CeraTest documentation,concerns I flagged and then dismissed because the numbers looked fine.

The numbers always look fine. That's the problem. Numbers can be made to look like anything.

---

The call from Harrison comes Thursday afternoon, while I'm knee-deep in an asset transfer agreement that requires six signatures from people who aren't returning emails.

"Ms. Alvarez." His voice is smooth, practiced,the tone of a man who knows exactly how much power he holds in any given conversation. "I hope I'm not interrupting."

"Not at all." I minimize the transfer agreement and give him my full attention. "What can I do for you?"

"I wanted to touch base before my trip next week. The CeraTest situation has evolved since we last spoke."

The CeraTest situation. The phrase sits wrong in my ear,too vague, too carefully neutral.

"Evolved how?"

"We've received preliminary results from the new testing round. The numbers are encouraging. Better than expected, actually."

"That's good news."

"It is." He pauses. "But I have concerns about continuity. The documentation trail seems... incomplete in places. I was hoping you might be willing to take another look before I make my final commitment."

My heart rate picks up. This is exactly what I was hoping for,a reason to dig deeper, an official invitation to look at the files again. But something about the way Harrison is asking makes me cautious.

"I'm currently assigned to the Vance deal," I say carefully. "Any additional work on Mobility Workshop would need to be cleared through Gloria."

"Already handled." His tone is casual, but I hear the calculation beneath it. "Gloria and I spoke this morning. She's willing to loan you out for a few days, given the circumstances."

The circumstances. Another vague phrase, another gap I'm not supposed to notice.

"And what circumstances would those be?"

"The CeraTest results are potentially transformative. If they hold up, Sam's company becomes a very different kind of investment,the kind that attracts attention from larger players. But if there are flaws in the methodology, if the testing wasn't as rigorous as the documentation suggests..." He trails off meaningfully. "Well. I prefer to know what I'm buying before I buy it."

"And you want me to find the flaws."

"I want you to find the truth. Whatever that turns out to be."

I stare at my laptop screen, where the minimized transfer agreement waits patiently for my attention. This is a gift,a chance to investigate my suspicions, to dig into the missing timestamps and calibration gaps that have been nagging at me since I first reviewed the files. But it's also a test. Harrison is watching to see what I find, and more importantly, how I handle what I find.

"When do you need the assessment?"

"Dev and I arrive Monday. I'd like your preliminary findings by Tuesday morning."

Five days. Less than five days to review months of testing data and identify whatever's hiding in the gaps.

"That's a tight timeline."

"I have faith in your abilities." His tone is warm, confident,the voice of a man who's used to getting what he wants. "Sam speaks highly of you. He says you notice things other people miss."

Sam speaks highly of me. The information lands somewhere complicated, somewhere I don't want to examine too closely.

"I'll have the preliminary assessment ready by Tuesday."

"Excellent. I'll send over the new data this afternoon." He pauses. "And Ms. Alvarez? I appreciate your discretion. Until we know what we're dealing with, I'd prefer to keep this between us."

"Of course."

He hangs up. I sit in silence, processing.

Harrison wants me to investigate CeraTest. Officially. With Gloria's blessing and access to the new data. It's exactly what I wanted,so why does it feel like I'm walking into something I don't fully understand?

---

The new CeraTest data arrives at 4:47 PM, four hundred pages of testing protocols, calibration records, and performance metrics. I download it to my laptop and stare at the folder icon, trying to decide whether to start tonight or wait until morning when my brain is fresher.

My phone buzzes.

**Sam:** Harrison called you.

Statement, not question. I wonder how he knows,if Harrison told him, or if he just knows me well enough to predict the timing.

**Me:** He wants me to review the new CeraTest results before he commits.

**Sam:** I know. He cc'd me on the email.

**Me:** Are you worried?

**Sam:** Should I be?

I think about the gaps in the documentation. The missing timestamps. The numbers that look too clean to be entirely honest.

**Me:** I don't know yet. But I'm going to find out.

**Sam:** That's either reassuring or terrifying.

**Me:** Why terrifying?

**Sam:** Because you're very good at finding things. And sometimes the things you find change everything.

I stare at my phone. The Vance documents are still open on my laptop, but they feel very far away now,paperwork from another life, another version of myself who wasn't about to spend the next five days investigating the foundation of something that matters more than she wants to admit.

**Me:** The methodology matters. If there are problems, you need to know before Harrison commits.

**Sam:** I know.

**Sam:** I'm just...

**Sam:** What if you find something? Something real?

**Me:** Then we deal with it. Together.

The word slips out before I can stop it. Together. Like we're a unit. Like we're something more than a lawyer and a client who kissed once and made a rule about not doing it again.

**Sam:** Together.

**Sam:** I like the sound of that.

**Me:** Sam.

**Sam:** I know. The rule.

**Me:** The rule.

**Sam:** It's getting harder, you know. The rule.

**Me:** I know.

**Sam:** Every day it gets a little harder to remember why we made it.

I close my eyes. My office is quiet, the building emptying out around me, and I can feel the weight of his words pressing against my chest. Every day it gets a little harder. He's right. The logic that seemed so clear in the workshop, with my lips still swollen and my body still humming,that logic feels thin now, worn through by three weeks of texts and midnight confessions and the memory of his thumb against my pulse.

**Me:** We made it because I'm your lawyer.

**Sam:** You're Gloria's associate. The assessment is officially complete.

**Me:** Harrison's final decision is still pending. I'm still technically involved.

**Sam:** Technically.

**Me:** Technically matters. Technically is the whole point.

**Sam:** What if I don't care about technically?

My fingers hover over the keyboard. There's a right answer here,a professional answer, the kind of response that maintains appropriate boundaries and protects both of us from complications. I know what that answer looks like.

**Me:** You should care. We both should.

**Sam:** But?

**Me:** But I'm finding it difficult to remember why.

The three dots appear. Disappear. Appear again, longer this time.

**Sam:** Berna.

**Me:** Yes?

**Sam:** Come to Forge & Flow tomorrow. Just for a few hours. We can look at the CeraTest data together.

**Me:** That's a terrible idea.

**Sam:** It's a professional meeting. Two colleagues reviewing documentation. Completely above board.

**Me:** At our coworking space? Where we have a history of doing things that are not above board?

**Sam:** The table incident was ONE time.

**Me:** The table incident was life-altering.

**Sam:** For both of us, I hope.

I'm smiling at my phone again, alone in my darkening office, surrounded by documents I should be reading and decisions I should be making. The Vance deal waits. Gloria's assessment waits. Harrison's timeline waits.

But Sam is asking me to come back.

**Me:** Ten AM. Professional attire. Fifteen feet of distance at all times.

**Sam:** Fifteen feet seems excessive.

**Me:** Take it or leave it.

**Sam:** Taking it. Happily. Desperately.

**Me:** Goodnight, Sam.

**Sam:** Goodnight, Berna.

**Sam:** Sleep well.

**Sam:** And thank you.

**Me:** For what?

**Sam:** For choosing together.

I turn off my phone and sit in the darkness for a long moment. Tomorrow I'll go back to Forge & Flow. Tomorrow I'll sit across from Sam and review data that might change everything for his company. Tomorrow I'll maintain fifteen feet of distance and pretend that every inch isn't torture.

The rule is holding.

But the cracks are getting wider. And I'm starting to think that might be okay.

---

Friday morning, I arrive at Forge & Flow at 9:47,thirteen minutes early, which gives me time to establish my position before Sam arrives. I set up at my usual table, laptop open, CeraTest files loaded, professional armor firmly in place.

Cassandra Webb is already in her central spot, ring light glowing, microphone positioned. She sees me come in and her face does something complicated,a mixture of delight and calculation that suggests she's been waiting for this.

"The return!" she announces, loud enough for the entire room to hear. "Day four of the cold war has officially ended. I'm getting my recorder."

"Please don't."

"Too late. This is exactly the kind of dramatic reconciliation my listeners love." She's already adjusting her equipment, positioning herself for optimal audio capture. "Are you here to apologize? To grovel? To make a dramatic declaration of,"

"I'm here for a professional meeting."

"Sure you are." Her grin is knowing, infuriating. "Professional meetings always involve that level of anticipatory tension. I can see it from here."

I don't dignify this with a response. I open the CeraTest files and pretend to read, but my attention is split,half on the documentation, half on the door.

At 10:02, Sam walks in.

He's wearing a blue sweater I haven't seen before,darker than his usual palette, with the sleeves rolled to his elbows in that particular way he has. His hair looks different too, slightly disheveled, like he ran his hands through it one too many times this morning.

He sees me. Stops. His whole body does that thing it does when I'm in the room,a subtle recalibration, an adjustment of attention that feels almost physical.

"Hi," he says.

"Hi."

Cassandra makes a noise that sounds like someone trying not to squeal.

Sam crosses the room toward my table, and I can feel every step like a countdown. Fifteen feet becomes twelve becomes ten becomes seven,

"Fifteen feet," I remind him.

"Right." He stops. Adjusts. Takes a step back. "Sorry. Habit."

"We don't have a habit."

"We have something." His voice is low, pitched for my ears only. "Whatever that something is."

Cassandra is definitely recording. I can see the red light on her equipment, blinking steadily.

"The data," I say, louder than necessary. "Let's review the data."

He pulls a chair to the opposite side of my table,fifteen feet, more or less,and opens his laptop. For the next two hours, we do exactly what we said we'd do: review testing protocols, cross-reference calibration records, compare performance metrics. It's careful, professional, completely appropriate.

It's also torture.

Every time he leans forward to point at something on his screen, the distance between us feels like a personal insult. Every time our eyes meet across the table, I have to remind myself why I can't just close the gap and,

"There." Sam's voice snaps me back to attention. "That timestamp. Do you see it?"

I lean in, squinting at his screen. "What about it?"

"It's out of sequence. The calibration check at 14:23 references data that wasn't recorded until 15:47."

I feel a chill run down my spine. "That's not possible. Unless,"

"Unless someone reconstructed the sequence after the fact." He looks at me, and his expression is serious now,the playful energy replaced by something harder, more focused. "Someone modified this data."

I pull my chair closer without thinking. Twelve feet becomes ten becomes eight,

"Show me," I say.

He turns his laptop toward me, and I see what he's seeing: a timeline that doesn't add up, references that point to data that didn't exist yet, a documentation trail that's been carefully constructed to look authentic but isn't.

"This is serious," I say quietly.

"I know."

"If the calibration data was modified, it could invalidate the entire testing round. Harrison needs to know."

"I know." Sam's voice is tight. "But if the test results are compromised, the investment falls through. Everything I've built,"

"Could survive." I meet his eyes. "If you handle it right. If you're transparent about the problem and show you're addressing it."

"That's easy for you to say."

"It's never easy." I reach across the table without thinking, my hand finding his wrist. His pulse beats against my fingers,steady, too fast, matching my own. "But it's the right thing to do."

He looks down at our point of contact. Looks up at me.

"This is less than fifteen feet," he says.

"I know."

"You're touching me."

"I know."

"Berna."

"I know."

I should pull away. Every professional instinct I have is screaming at me to release his wrist and restore the appropriate distance. But his skin is warm under my fingers, and his pulse is racing, and I can see in his eyes exactly what I'm feeling,the exhaustion of wanting something you can't have, the relief of finally touching it again.

"The rule," he says.

"Is cracking."

"And you're okay with that?"

I think about it. About Harrison's investigation and Gloria's scrutiny and the complications that will inevitably follow if we let this crack widen. About the career I've built and the boundaries I've maintained and the careful architecture of a life designed to prevent exactly this kind of vulnerability.

"No," I say. "I'm terrified."

"But?"

"But I'm also tired of pretending I don't want this."

His free hand moves. Slow, deliberate, giving me time to stop him. His fingers touch my jaw,just for a moment, just the lightest brush of contact,and the touch sends electricity through every nerve in my body.

"After," he says. "When this is over. When Harrison decides and the professional connection ends,"

"Ask me then."

"I'm asking you now."

"Then my answer is: ask me then."

He laughs,a short, surprised sound that makes Cassandra's head whip toward us. I pull my hand back from his wrist. He pulls his hand back from my face. We sit there, fifteen feet apart again, pretending we didn't just cross every line we agreed not to cross.

"The data," I say, clearing my throat. "We should document what you found."

"Right." His voice is slightly unsteady. "The data."

We spend the next hour building a case. By the time we're done, we have fourteen documented inconsistencies, seven impossible timestamps, and a pattern that suggests systematic manipulation.

It's damning. It's also, potentially, the end of everything Sam has worked for.

"I'll call Harrison," I say, closing my laptop. "He needs to see this before Tuesday."

"I know." Sam's face is carefully neutral, but I can see the fear underneath,the awareness of how much he stands to lose.

"We'll figure it out," I say. "Together."

"Together." He stands, gathering his things. "That word keeps coming up."

"It does."

"I like it."

"I like it too."

He walks past me on his way out, and for just a moment,half a second, maybe less,his hand brushes against my shoulder. It's barely contact. It's barely anything.

It's everything.

"See you Monday," he says.

"See you Monday."

He leaves. Cassandra is staring at me with an expression of pure, undisguised satisfaction.

"Business rivals," she says. "My left foot."

I don't argue. For once, I don't have the energy to pretend.

---

That night, at 11:47, my phone lights up.

**Sam:** Thank you for today.

**Me:** For finding evidence that might destroy your investment prospects?

**Sam:** For being honest about it. For helping me figure out what to do.

**Sam:** For touching my wrist.

I stare at the message. My chest feels tight, full of something I'm not ready to name.

**Me:** The rule is getting harder to follow.

**Sam:** I know.

**Sam:** Is that okay?

**Me:** Ask me after Harrison decides.

**Sam:** And if he decides badly?

**Me:** Then at least we'll know. At least the professional entanglement will be over.

**Sam:** And then?

**Me:** And then we'll figure out what together means.

**Sam:** I can work with that.

**Sam:** Goodnight, Berna.

**Me:** Goodnight, Sam.

I put my phone on the nightstand and lie in the dark, thinking about timestamps and touch and the specific temperature of his skin against mine.

The rule is cracking. The investigation is getting complicated. Harrison's decision looms like a verdict I'm not prepared to hear.

But somewhere underneath all the uncertainty, there's something else: the solid, undeniable knowledge that whatever happens next, I won't be facing it alone.

Together.

I'm starting to think that word might be enough.

$akm001ch8$,
  3696
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  9,
  'Chapter 9: Controlled Burn',
  $akm001ch9$
# Chapter 9: Controlled Burn

The workshop is different at night.

I've been here during business hours,bright fluorescent overheads, the distant hum of equipment from the main production floor, the steady rhythm of people moving through their workdays. But now, at 8:47 PM on a Sunday, with most of Portland tucked into their homes watching prestige television, the space feels like a secret.

Sam unlocks the side entrance with the practiced ease of someone who does this often. Late nights, probably. Working on designs when the building is empty and his thoughts can spread out across the workbenches without interruption.

"The data server is in the back," he says, holding the door for me. "I pulled everything when I got your text. Figured you'd want to see the original files, not just the exports."

I step past him into the dim corridor. The emergency lights cast everything in amber, and I'm acutely aware of how much smaller the space feels without the bustle of employees. How much more enclosed.

"Harrison wants my assessment by Tuesday," I say, keeping my voice professional. Clinical. "I need to see the quality control logs from the CeraTest pilot. The original ones, not the reconstructed versions."

"I know." Sam moves past me, close enough that I catch his scent,machine oil tonight, and something sharper underneath, like he's been welding recently. "That's what worries me."

He leads me through the production floor, where finished prototypes line the walls in various stages of completion. Wheelchairs with customized seating. Prosthetic limbs with sensors I don't fully understand. A child-sized walker painted with cartoon dinosaurs that makes my throat unexpectedly tight.

"These are beautiful," I say before I can stop myself.

Sam glances back at me. "That one's for a girl named Maya. Seven years old. She wanted velociraptors specifically. Very particular about the species."

"Did you paint them yourself?"

"My production manager has actual artistic talent. I just do the engineering." He pauses by a workbench covered in scattered components. "But yeah. I helped."

I look at the velociraptors,anatomically questionable but clearly beloved, their tiny clawed hands raised in cheerful greeting,and something in my chest shifts. This is what he does. Not the investor meetings or the competitive positioning or the legal complications. This. Building things that help people move through their lives.

"The server room's through here," Sam says, and I realize I've been standing there staring at dinosaurs for too long.

*Focus, Alvarez.*

---

The server room is climate-controlled, which means it's approximately fifteen degrees colder than the rest of the building. I cross my arms against the chill, wishing I'd brought a jacket, and watch Sam navigate the filing system with practiced efficiency.

"Here." He pulls up a folder on the monitor. "Original quality control data from the CeraTest pilot. I haven't touched these files since we submitted them to Harrison's team. Date stamps should prove that."

I lean in to look at the screen, aware that this puts me closer to him than strictly necessary. His shoulder is maybe four inches from mine. I can feel the heat radiating off his body, a sharp contrast to the cold server room air.

"Can you scroll down to the material testing section?"

He does. I study the timestamps, comparing them to the modified versions I photographed from Jenna's analysis. The originals are clean,consistent intervals, no gaps, no signs of reconstruction.

"Someone altered these after submission," I say slowly. "But who had access to the files once they left your system?"

"Harrison's team. Their due diligence consultants." Sam's voice is tight. "And whatever third-party lab they contracted for independent verification."

"Jenna Chen's lab."

"Possibly." He turns to face me, and the movement brings us closer. Too close, maybe. His eyes are dark in the server room's blue-tinted light. "Do you think she modified her own data? Or do you think someone modified it after she submitted her analysis?"

"I don't know yet." I force myself to focus on the screen instead of the sharp angle of his jaw. "But I'm going to find out."

"Harrison trusts her."

"Harrison trusts data. If I can show him the original files don't match what Jenna presented, he'll have questions."

Sam exhales. "And if those questions lead back to someone trying to sabotage the deal?"

"Then we find out who. And why."

He's quiet for a moment. Then: "Thank you. For doing this."

"It's my job."

"No, it isn't." His voice is low, certain. "Your job is to protect Harrison's interests. To make sure he doesn't invest in a company that's going to blow up in his face. This,helping me figure out who's manipulating the data, working on a Sunday night because you believe something isn't right,that's not your job. That's you."

I don't know what to say to that. The server room hums around us, and I'm suddenly aware of how alone we are. The building is empty. The city is quiet. And Sam is looking at me like I'm the most important thing in this room full of technology.

"We should," I start.

"Copy the files," he finishes. "I know. I have a USB drive somewhere."

He turns to search the nearby desk drawer, and I let out a breath I didn't realize I was holding.

---

Ten minutes later, we have the original data secured and I'm following Sam through a different section of the building,some kind of design lab, from the looks of it. Half-finished prototypes cover every surface, sketches pinned to the walls, a whiteboard filled with equations I can't even pretend to understand.

"Sorry," he says, noticing my expression. "I forget how it looks to people who don't live here."

"It looks like the inside of your brain."

He laughs,surprised, genuine. "That obvious?"

"You've got three different versions of the same wheelchair component spread across two tables and a chair. Either you're a hoarder or you're iterating."

"Iterating." He picks up one of the components,a wheel mechanism, sleek and complicated. "This one's too heavy. This one's not durable enough. This one..." He turns it over in his hands, studying it. "This one might actually work."

"What's it for?"

"Beach access." He sets the component down. "Most wheelchairs can't handle sand. The wheels sink, the motors overheat. I've been trying to design something that can actually let people get to the water without needing a team to carry them."

I think about that. About someone sitting at the edge of a beach, watching their family play in the waves, wanting nothing more than to feel the sand between their wheels and the spray of salt water on their face. About Sam, staying late in his workshop, trying to solve that problem.

"You really love this," I say.

"Yeah." He's watching me now, not the prototype. "I really do."

The moment stretches between us. I should say something professional. Something about the data, or the timeline, or the meeting with Dev Chen tomorrow. Instead I'm standing in Sam Reyes's design lab at nine o'clock on a Sunday night, watching him hold a piece of metal like it's a living thing, and all I can think about is how his hands would feel on my skin.

"We should go," I say, but my voice comes out rougher than I intended.

"Berna."

The way he says my name makes something tighten in my chest. Not warmth,that would be too soft. This is heat. Concentrated and specific, pooling low in my stomach.

"Sam,"

"I know." He sets down the wheel component. "I know we should go. I know tomorrow Dev arrives with Harrison. I know there are approximately seventeen professional reasons why I should keep my hands to myself."

"Then why does it sound like you're about to list a counter-argument?"

His mouth curves. Not quite a smile. Something more dangerous. "Because I've been counting the reasons for months now, and I'm starting to lose track."

"That's what it feels like, isn't it?" He takes a step toward me. Just one, but the design lab isn't that large. The distance between us shrinks to something almost manageable. Almost. "Like we've been building toward something, and every time we get close, we pull back. Every time I think maybe this is the moment, something interrupts."

"The interruptions are usually called 'professional ethics.'"

"I know." Another step. "I have them too. I think about the deal, and Harrison, and what happens if this falls apart because I couldn't keep my hands to myself. I think about your career and your firm and the fact that you're brilliant and ambitious and deserving of a partnership you've worked years for."

My back touches the edge of a workbench. I didn't realize I'd been retreating.

"That's a lot of thinking," I manage.

"I'm an engineer. We overthink everything." He stops, barely a foot away from me now. Close enough that I can see the individual stitches in his collar. Close enough that the heat from his body cuts through the chill still clinging to me from the server room. "But here's the thing, Berna. I've been thinking about all the reasons we shouldn't, and none of them are making me want you any less."

I should stop this. I should say something about boundaries, or timelines, or the complicated legal entanglement that makes this categorically inadvisable. Gloria's voice is in my head, listing every reason this is a mistake.

Instead, I say: "What do you want?"

His eyes meet mine. Direct. Certain. "You. Just you."

And then I stop thinking at all.

---

His hands find my waist first,not tentative this time, not a brush of contact that could be explained away. His grip is firm, deliberate, and when he pulls me against him, the full length of his body against mine, I hear myself make a sound I don't entirely recognize.

"Tell me if,"

"Don't stop," I say, and he doesn't.

His mouth covers mine, and it's nothing like the kiss at Marco's. That was soft. Questioning. This is an answer,to every weighted silence, every almost-touch, every moment in the past three weeks when we've pretended the air between us wasn't combustible.

I grip the front of his shirt, feeling the cotton bunch under my fingers, feeling the solid heat of his chest underneath. He's broader than I expected. Denser. When I press my palms flat against him, I can feel his heartbeat,rapid, urgent, matching my own.

"Wait," He pulls back, just far enough to look at me. His breathing is uneven, his pupils blown wide. "The workbench has actual equipment on it. Let me,"

He reaches behind me to sweep a pile of sketches out of the way. They scatter across the floor in a cascade of engineering drawings, and I laugh,actually laugh,because of course. Of course our first real kiss happens surrounded by wheelchair prototypes and beach-access schematics.

"Very smooth," I say.

"I aim to impress." His hands return to my waist, and this time he lifts me,actually lifts me,onto the cleared edge of the workbench. My skirt rides up. I don't care. His hips slot between my knees, and the position puts us at almost the same height. Puts his face level with mine.

"Better," he murmurs, and kisses me again.

I lose time. I don't know how else to describe it. One moment I'm perched on the edge of a workbench in a dim design lab, and the next his mouth is at my throat and my fingers are twisted in his hair and the sounds I'm making would be embarrassing if I had any capacity left for embarrassment.

His hands slide up my sides, fingers tracing the line of my ribs through the thin fabric of my blouse. The touch is almost reverent,like he's memorizing the shape of me. Like he's been thinking about this for as long as I have.

"This shirt has too many buttons," he says against my collarbone.

"That sounds like an engineering problem."

His laugh vibrates against my skin. "Give me thirty seconds."

His fingers find the first button. Then the second. He's careful,methodical in a way that makes me want to scream,and by the time he reaches the third, I'm actively considering just ripping the damn thing off myself.

"Sam,"

"Patience." But his voice is strained, and when his knuckles brush the bare skin of my stomach, I feel him shudder. "God, Berna. You're,"

"If you say 'beautiful' right now, I'm going to assume you learned flirting from a Hallmark movie."

"I was going to say 'cold.'" His hand presses flat against my abdomen, and I realize he's right,my skin is still chilled from the server room, goosebumps rising everywhere his fingers aren't. "Let me fix that."

He pulls me closer. Wraps his arms around me. Presses his chest against mine until all I can feel is him,the solid heat of his body, the rough scratch of his shirt against my bare stomach, the rapid thud of his heart against my own.

"Better?" he asks.

I don't trust myself to answer. Instead, I pull his mouth back to mine.

---

Time loses meaning entirely. At some point, his shirt joins my blouse,discarded somewhere on the floor amid the scattered schematics,and I finally get to touch him the way I've been imagining. His shoulders are broader without the cotton barrier. His chest is dusted with dark hair that trails down past his belt. When I drag my nails lightly down his sides, he makes a sound,not quite a groan, something sharper, hungrier,that sends electricity straight to my core.

"Berna." His voice is ragged. "We need to,I should,"

"Don't think," I tell him. "Not right now."

His hand slides up my thigh, under the bunched fabric of my skirt, and I stop being able to form complete sentences. His palm is rough,callused from years of building things,and the contrast against my skin makes me arch into him.

"Tell me what you want," he says, echoing my earlier question. His mouth is at my ear, his breath hot against the sensitive skin there.

"I want,"

And then my phone buzzes.

We both freeze. The vibration cuts through the silence of the workshop, insistent and unwelcome, and I feel Sam's grip tighten reflexively on my thigh before he forces himself to loosen it.

"You should check that," he says. He doesn't move back. Doesn't let go.

I reach for my bag, abandoned somewhere behind me on the workbench, and fish out my phone with fingers that aren't entirely steady.

It's a text from Gloria.

*Harrison called. Dev Chen's flight landed early. Meeting moved to 7 AM tomorrow. Be at the office by 6:30.*

I stare at the screen. The words swim in front of my eyes, not quite resolving into meaning.

"Bad news?" Sam asks.

"Dev's here." I look up at him. He's still standing between my knees, still shirtless, still looking at me like I'm the most important thing in any room I happen to occupy. "The meeting's in ten hours."

Reality crashes back in. Not gently,reality never does,but with the full weight of professional obligation and legal complexity and the seventeen reasons Sam listed earlier for why this was inadvisable.

His hands fall away from my thigh. He takes a step back. The cold air rushes in to fill the space where his body was, and I resist the urge to pull him back just to stay warm.

"You need to go," he says.

"I need to go," I agree.

Neither of us moves.

"Berna." His voice is quiet. Serious in a way I haven't heard before. "I'm not going to pretend this didn't happen. Tomorrow, when we're in that meeting with Harrison and Dev and everyone's talking about my company like it's just numbers on a spreadsheet, I'm still going to be thinking about this. About you."

"I know." I hop down from the workbench, suddenly aware of how disheveled I must look. "I will too."

I find my blouse on the floor, shake out the worst of the wrinkles, start re-buttoning with fingers that still aren't quite steady. Sam watches me dress, making no move to retrieve his own shirt, and there's something in his expression that makes my chest ache.

"This isn't an ending," he says. "Whatever happens tomorrow,this isn't an ending."

"I know."

"But it also can't be a beginning. Not yet. Not while you're still,"

"Sam." I cross to him, fully dressed now except for the buttons I missed and the hair that's definitely not surviving this encounter intact. I put my hand on his bare chest, feeling his heart still racing under my palm. "I know what I'm risking. I've known since the first time you showed me a wheelchair designed for a seven-year-old who wanted velociraptors. This isn't just attraction. This isn't just chemistry. This is me, choosing you, even when I know better."

His hand covers mine. "So what do we do?"

"We get through the meeting tomorrow. We figure out who's sabotaging your data. We prove to Harrison that Mobility Workshop is exactly what he thinks it is,a good investment, run by a good man, making things that actually help people." I take a breath. "And then, when the professional entanglement is resolved,"

"When there's nothing standing between us except our own choices."

"Then we make one."

He studies me for a long moment. Then he lifts my hand from his chest and presses a kiss to my palm,not passionate this time, but tender. A promise.

"I'll hold you to that," he says.

$akm001ch9$,
  2917
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  10,
  'Chapter 10',
  $akm001ch10$
# Chapter 10

The Harrison Webb meeting ends at 4:47 PM.

I know the exact time because I've been watching the clock on the conference room wall for the last three hours, tracking minutes like a lawyer billing in six-minute increments while my brain replays last night on a loop that has nothing to do with assistive devices or Series A funding.

"Well." Harrison Webb stands, buttoning his jacket with the practiced ease of a man who's ended a thousand meetings. "I think we have everything we need."

Dev Chen is already packing up his laptop, but there's something different in his expression now,less skeptical, more... curious. The data discrepancies he found turned out to be a formatting error from when Sam's CTO migrated databases last quarter. Three hours of forensic accounting to confirm what I suspected from the beginning: Mobility Workshop's books are clean because Sam Reyes doesn't know how to be anything other than exactly who he is.

"We'll be in touch within the week," Harrison continues, extending his hand to Sam. "I want to discuss your expansion timeline with my partners, but I'll be honest,I'm optimistic."

Sam shakes his hand, and I catch the slight tremor in his fingers. He's been running on coffee and adrenaline since six AM, when we met to prep. His shirt is slightly rumpled. There's a coffee stain on his left cuff that he hasn't noticed.

He's never looked better.

"Thank you for the opportunity," Sam says, and his voice is steady even if his hands aren't. "Whatever you decide, I appreciate the thorough process."

Harrison's eyebrows lift,just slightly, just enough that I catch it. He's used to founders who grovel, who oversell, who perform gratitude while calculating angles. Sam's sincerity throws him.

Good.

"Ms. Alvarez." Harrison turns to me. "Excellent work on the documentation. Very thorough."

"Thank you." I keep my voice professional, my handshake firm. "Safe travels back to San Francisco."

The door closes behind them.

For a long moment, neither of us moves. The conference room feels suddenly enormous, all that polished wood and expensive lighting containing just the two of us and whatever this is that's been building since,

"That went well." Sam's voice is careful. "Right? That went well?"

"That went very well." I'm gathering papers I don't need, organizing documents that are already organized. "Dev's body language shifted around the two-hour mark. When you showed him the customer retention data."

"The numbers don't lie."

"No." I look up at him. "They don't."

The air between us feels charged, electric. My skin remembers last night,his hands, his mouth, the way he'd touched me like I was something precious and powerful simultaneously.

"Berna." Sam takes a step toward me. "The engagement is over."

"Technically, Harrison hasn't signed,"

"The engagement is over." He says it again, firmer this time. "Dev found what he was looking for. The due diligence is complete. Whatever Harrison decides, your firm's work is done."

My heart is doing something complicated in my chest. "Gloria will send the final invoice."

"Great." Another step. "So there's no professional conflict anymore."

"No." My voice comes out rougher than I intended. "There isn't."

Sam stops three feet away. His eyes are dark, intent, and there's something almost nervous in the way he's holding himself,shoulders slightly tensed, like he's bracing for impact.

"I want to take you to dinner," he says. "A real dinner. At a restaurant where neither of us is thinking about term sheets or investor due diligence or any of the other bullshit that's been keeping us from," He stops, swallows. "I want to take you on an actual date, Berna. I want to pick you up at your apartment and hold your hand across the table and not have to calculate whether kissing you goodnight constitutes a conflict of interest."

My laugh comes out surprised. "You calculated that?"

"I calculated everything." His mouth curves into something self-deprecating. "I'm an engineer. It's what I do."

I close the distance between us.

"Here's a calculation for you." I'm standing close enough now that I have to tilt my head back to meet his eyes. "If we go to dinner, we're not going to make it through the appetizers. I've been thinking about last night since the moment I left your apartment, and I have very specific plans that don't involve restaurant seating."

Sam's breath catches. "Berna,"

"My place is twelve minutes away." I grab my bag, my coat. "Your place is sixteen. Mine has better wine."

"I don't care about the wine."

"I know." I'm already moving toward the door. "Come on."

---

The Uber ride is its own kind of torture.

We're sitting a respectable six inches apart because this is Portland and the driver is making small talk about the weather, but Sam's hand finds mine between the seats and his thumb traces circles on my palm that send electricity straight to my spine.

"Nice day for it," the driver says, completely oblivious. "Rain's supposed to hold off until tomorrow."

"That's great," Sam manages. His voice sounds strangled.

I bite the inside of my cheek to keep from laughing.

By the time we reach my building, I've lost the ability to make conversation. The elevator takes approximately seven hundred years to arrive. When it finally does, we're inside for exactly three seconds before Sam's mouth is on mine.

"God." He's pressing me against the elevator wall, one hand in my hair and one at the small of my back, and his kiss is hungry in a way that makes my knees actually go weak. "I've been thinking about this all day. During the entire meeting. Harrison was talking about runway projections and I was thinking about how you taste."

"Very professional." I'm fumbling for my keys, but it's hard to find anything when his lips are moving down my neck.

"I'm not your lawyer anymore."

"No." I finally locate my keys, somehow manage to get them into the lock. "You're not."

The door swings open and we're inside, and I have about half a second to feel grateful that I cleaned last weekend before Sam is kissing me again.

"Where's," He pulls back, disoriented.

"Down the hall. Second door on the left."

He nods, takes my hand, and leads me toward my own bedroom like he's already memorized the floor plan. Which is very Sam, actually,observing, cataloging, building a mental map of any space he enters.

My bedroom is small and imperfectly lit, afternoon sun filtering through curtains I've been meaning to replace. Sam doesn't seem to notice the décor. He's too busy looking at me.

"Hi." His voice is softer now, hands settling on my hips with a gentleness that makes my chest ache.

"Hi."

"We should probably talk about,"

I reach up and start unbuttoning his shirt. "Later."

"But,"

"Sam." I undo the third button, the fourth. "I've been waiting months for this. We can process feelings afterward."

His laugh is surprised, delighted. "Months?"

"Since the supply chain presentation." Button five, button six. "You were explaining regulatory compliance and I had to excuse myself to get water because I was thinking about your hands."

"My hands?"

"You build things." I push his shirt off his shoulders and there he is,the broad chest I traced last night, the shoulders that have been taking up space in my imagination. "I kept thinking about how you must touch things. Carefully. Deliberately."

Sam makes a sound that's somewhere between a groan and a prayer. "You were thinking about that during the supply chain presentation?"

"I was thinking about that during every presentation." I pull my own blouse over my head, not bothering with the buttons. "I was thinking about it during contract negotiations. I was thinking about it when you shook my hand after the first Harrison meeting and your palm was warm and rough and I had to go home and take a very long shower."

"Oh god." He's staring at me,my bra is practical black cotton, not remotely seductive, but from the look on his face it might as well be hand-stitched French lace. "Berna."

"Stop looking at me like that and come here."

He comes.

---

Here's what I didn't expect: laughter.

Sam's belt buckle gets stuck, and he swears creatively in Spanish,"My grandmother was from Guanajuato," he admits when I raise my eyebrows,and we're both laughing as he wrestles with the mechanism while I try to help and mostly make things worse.

My bra clasp defeats him entirely. "Why is this so complicated? I build medical devices. I have a engineering degree. This should not be,"

"It's a front clasp."

He stops. Looks down. Looks up at me with an expression of such profound betrayal that I actually snort.

"A front clasp," he repeats.

"I was trying to make it easier."

"I thought that was a decorative element."

"It's a clasp, Sam. It's between my breasts. The logic isn't exactly hidden."

He unhooks it, finally, and then his hands are on me and the laughter dissolves into something hotter, more urgent.

"You're beautiful." His voice is reverent, and his thumbs are tracing circles that make rational thought difficult. "I need you to know,I kept trying to be professional. I kept trying to treat this like a business relationship. But every time you walked into a room I had to remind myself how to breathe."

"That seems inefficient."

"It was." He kisses me again, slower this time, deeper. "It was incredibly inefficient. I lost approximately seventy-three productive hours thinking about you."

"You tracked it?"

"I'm an engineer." His mouth moves to my jaw, my throat, the spot below my ear that makes me gasp. "It's what I do."

We make it onto the bed eventually, a tangle of half-removed clothing and bare skin and hands that can't quite decide where to settle. Sam kisses down my sternum, pausing to mouth at the curve of my ribs, and when he looks up his eyes are dark with something that makes heat pool low in my stomach.

"I want," He stops. "Can I,"

"Yes." I don't even know what he's asking. I don't care. "Whatever it is. Yes."

His grin is quick, startled. "You don't know what I was going to say."

"I don't care."

"That's not very lawyerly."

"I'm not your lawyer anymore."

Something shifts in his expression,recognition, maybe, or relief. "No. You're not."

He pulls my underwear down slowly, deliberately, and I feel exposed in a way that has nothing to do with nudity. Sam looks at me like he's memorizing plans, like he's building something in his head that he wants to get exactly right.

"Berna." His voice is rough. "I'm going to take my time with this."

"That's," I start to say something clever, something deflecting, but then his mouth is on me and I lose the capacity for speech.

---

Sam Reyes, as it turns out, approaches intimacy the way he approaches engineering problems: with patience, curiosity, and an almost obsessive attention to detail.

He catalogues my responses like data points. Pressure here, reaction there. When I gasp, he repeats the motion exactly, testing the hypothesis. When I moan, he increases the variable.

"You're taking notes," I manage, when I can form words again.

He lifts his head, and his smile is devastatingly smug. "I'm gathering information."

"That's," I can't finish the sentence because he's gone back to work, and apparently Sam Reyes has been gathering information about the female anatomy since well before he met me, because what he's doing should require a license.

I come with my hand fisted in his hair and his name on my lips, and he works me through it with the same methodical patience, gentling his touch exactly when I need him to, extending the sensation until I'm boneless and gasping.

"Good?" he asks, kissing his way back up my body.

I pull him up and kiss him, tasting myself on his tongue. "Get up here."

He settles over me, and I can feel him,hard and insistent against my thigh,and I want everything at once. I want to take my time like he did; I want to swallow him whole; I want to map every inch of his body and figure out exactly what makes him lose that careful control.

"Condom," I manage. "Nightstand. Left drawer."

He reaches over, retrieves one, tears the wrapper with his teeth in a way that shouldn't be attractive but absolutely is. I watch him roll it on, and something about the practiced efficiency of the motion sends another wave of heat through me.

"Hi," he says again, settling back over me.

"Hi." My voice cracks.

"You okay?"

I reach up and touch his face,the stubble along his jaw, the slight furrow between his eyebrows. "I'm good. I'm," I laugh, because the emotion swelling in my chest is too big for language. "I'm really good."

Sam kisses me, soft and sweet, and then he's pushing inside me, and the stretch is perfect,not quite comfortable, not quite painful, exactly right.

We both go still.

"Okay?" His voice is strained.

"Move. Sam,please,"

He does. Slowly at first, building a rhythm that's deliberately torturous, and I can feel him holding back, can see the effort in the tension of his shoulders and the set of his jaw.

"You're not going to break me." I dig my nails into his back. "I'm not one of your prototypes."

His laugh is startled, breathless. "That's the least sexy thing anyone has ever said to me during sex."

"Then stop treating me like I'm fragile."

Something changes in his expression. The careful control slips, just slightly, and his next thrust is harder, deeper, exactly what I needed.

"Like that," I gasp. "God, Sam,"

He finds an angle that makes stars burst behind my eyes, and I stop thinking entirely. There's just sensation,the weight of him over me, the rhythm we're building together, the small sounds he's making against my neck.

"You feel," His voice breaks. "Berna, you feel incredible."

"I know." It comes out more smug than I intended, and his laugh vibrates against my skin.

"Modest."

"Realistic."

He shifts, hitches my leg higher over his hip, and the new angle makes me cry out.

"There?" He's grinning now, sweat beading at his temples. "Was that,"

"Yes. God. There. Don't stop,"

He doesn't stop. He builds and builds, that engineering precision applied to exactly the right purpose, and when I come this time it's with him,his rhythm stuttering, his face buried in my neck, my name falling from his lips like a prayer.

---

Afterward, we lie tangled together in my disheveled bed, catching our breath.

"So," Sam says eventually. His hand is tracing lazy patterns on my hip.

"So."

"That was..."

"Yeah." I can't stop smiling. It's embarrassing. "It was."

He props himself up on one elbow, looking down at me with an expression so tender it makes my chest hurt. "I thought about making a joke about optimal outcomes, but it seemed too on-brand."

"It would have been very on-brand."

"I know. That's why I didn't do it." He kisses me, soft and quick. "I'm trying to expand my range."

I reach up and trace the line of his jaw. "Sam."

"Yeah?"

"I'm glad the engagement's over."

"Me too." He catches my hand, presses his lips to my palm. "I mean,I hope Harrison invests. I need the funding. But if the price of getting his money was not being able to do this," He gestures vaguely at our entangled bodies, the wrecked sheets, the bra I'm fairly certain ended up on the ceiling fan. "I would have walked away."

I know he's serious. That's the terrifying thing. Sam Reyes would have tanked his company's chance at crucial funding because of whatever this is between us.

"That would have been very stupid."

"Probably." He doesn't sound concerned. "I've made worse decisions."

"Name one."

"That time I tried to pitch Harrison Webb while secretly falling for my legal counsel?"

I laugh, surprising myself. "Technically you hadn't fallen yet. That came later."

"Berna." His expression shifts, more serious now. "I was falling for you the moment you corrected my terminology in the first meeting. You said 'actually, the standard definition is' and I thought 'oh no, I'm in trouble.'"

"That was about contract law."

"I know. You were explaining indemnification clauses. It shouldn't have been attractive." His smile is rueful. "And yet."

I pull him down and kiss him properly, trying to communicate through action what I'm not quite ready to say in words. He responds immediately, his body covering mine, and I can feel him stirring again against my thigh.

"Already?" I ask, laughing.

"I told you." He's kissing down my neck, clearly headed for round two. "I had seventy-three hours of fantasies to work through."

"That seems excessive."

"It seemed necessary."

His mouth finds my breast, and I stop arguing.

---

Much later, when the light through my curtains has gone gold and then purple and then dark, we order Thai food and eat it in bed.

"This is probably unhygienic," Sam says, balancing a container of pad see ew on his chest.

"Probably." I steal a bite of his noodles. "I don't care."

"Me neither." He's watching me with that expression again,tender, wondering, like he can't quite believe this is happening. "Berna?"

"Mmm?"

"What happens now?"

I consider the question while chewing. It's a good question. The engagement is over, but that doesn't mean the complications have disappeared. He's still a client,former client,of my firm. There will still be paperwork, final invoices, the lingering professional connection.

But we've crossed a line that can't be uncrossed. I'm lying naked in bed with Sam Reyes eating his dinner, and I don't want to be anywhere else.

"Now," I say finally, "we figure out how to do this for real. Not stolen moments or interrupted conversations or whatever we've been doing for the past few weeks."

"An actual relationship."

"If you want."

"If I," He sets down his food, turns to face me fully. "Berna. I just told you I tracked the hours I spent thinking about you. I have a spreadsheet. There are categories."

I can't help it. I start laughing.

"There are categories?"

"I was losing my mind." He's smiling, but his eyes are serious. "You walked into my life and turned everything upside down and I had to put it somewhere. So I made a spreadsheet."

"What are the categories?"

"No." He shakes his head. "Absolutely not. I've already revealed too much."

"Sam."

"Some things should remain mysterious."

I set down my own food, climb into his lap, feel his sharp inhale as our bare skin presses together. "Tell me the categories."

"You're not playing fair."

"I'm a lawyer." I roll my hips, just slightly. "I never play fair."

He groans. "Fine. One of them was 'things she said that shouldn't have been attractive but were.' Another was 'outfits, ranked.' And there was," He stops, his face going red. "There was one called 'realistic scenarios.'"

"Realistic scenarios?"

"As opposed to unrealistic ones. Which I also tracked."

I stare at him. Sam Reyes, founder and CEO, builder of things that help people, keeper of spreadsheets cataloguing fantasies about his legal counsel.

"I love you," I say.

The words slip out before I can stop them. They're too big, too soon, too everything,but I watch his face transform, watch the surprise give way to something that looks almost like relief.

"Oh thank god." His voice is rough. "I've been trying not to say that for weeks."

"Say it now."

"I love you." He cups my face in his hands, those careful capable hands. "I love how your brain works. I love that you corrected my terminology. I love that you made me wait and that you chose me anyway and that you're here now, eating my pad see ew in the bed we just destroyed together."

"You're getting noodle sauce on my sheets."

"I'll buy you new sheets."

"You can't buy your way out of every problem."

"Watch me." He kisses me, quick and fierce. "I will buy you so many sheets, Berna. Thread counts you've never dreamed of. Egyptian cotton. Silk. Whatever you want."

I'm laughing again,I've laughed more in the last few hours than I have in months,and Sam swallows the sound with his mouth.

"New sheets tomorrow," he murmurs against my lips. "Right now I want to mess these ones up again."

So we do.

---

Later still, in the quiet dark, Sam's breathing has gone slow and even beside me.

I watch him sleep,the slack of his jaw, the furrow smoothed from his forehead, the way his hand still rests on my hip like he's afraid I'll disappear if he stops touching me.

$akm001ch10$,
  3461
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  11,
  'Chapter Eleven',
  $akm001ch11$
# Chapter Eleven

The first thing I register is that I'm warm. Not just comfortable,actually warm, which is unusual because I keep my apartment at sixty-four degrees and sleep under a single sheet like a reasonable person who pays her own utilities.

The second thing I register is that I'm not in my apartment.

The third thing is Sam's arm, heavy across my waist, and his breath slow and even against the back of my neck.

I don't move. I catalog the moment instead: morning light through blinds that hang crooked, the smell of coffee that someone must have set on a timer, a pillowcase that's definitely not the 400-thread-count sateen I special-ordered from a company that probably exploits someone somewhere but at least my face doesn't break out.

His pillowcase is flannel. It has been noted.

I should find this objectionable. I find it, inexplicably, charming.

"You're awake," Sam murmurs against my shoulder. "I can hear you thinking."

"You cannot hear thinking."

"I can hear *your* thinking. It's very loud." His arm tightens around me. "What are you thinking about?"

"Your pillowcase."

"What about it?"

"It's flannel."

"Okay?"

"Thread count?"

He laughs, this low rumble I feel more than hear. "The horror."

"I'm just observing."

"You're judging my bedding choices." He presses a kiss to my shoulder blade. "Five minutes into being my girlfriend and you're already judging my bedding choices."

Girlfriend. The word lands somewhere soft in my chest, unexpected. We haven't discussed this. We haven't discussed anything, actually,we were too busy with other activities, and then we were sleeping, and now apparently we're using terminology.

"Is that what I am?"

Sam goes still behind me. Then he shifts, propping himself up on one elbow so he can see my face. His hair is a disaster. There's a pillow crease across his cheek. He looks ridiculous and perfect and I want to bite his jaw for reasons I don't fully understand.

"Do you want to be?"

I consider this with the seriousness it deserves. "I don't know. I've never had one before."

"A boyfriend?"

"A label." I turn onto my back so I can look at him properly. "The relationships I've had have been more... provisional."

"Provisional," he repeats, mouth twitching. "Like a patent application?"

"I was going to say contingent, but sure. Patent application works."

He traces a line from my collarbone to my shoulder, thoughtful. "I'd like you to be my girlfriend. But we can call it whatever you want. Or nothing. Or,"

"Girlfriend is fine."

The smile that breaks across his face is unreasonable. "Yeah?"

"Don't make it weird."

"I'm not making it weird. You made it weird by comparing our relationship to patent law."

"Intellectual property is a perfectly respectable,"

He kisses me. It's a good strategy for ending an argument, and I file it away for future reference.

---

We make it out of bed eventually, though it takes longer than it should because Sam keeps finding reasons to touch me,my hip as I look for my clothes, my waist as I pass him in the narrow hallway, my hand while we're literally just standing in his kitchen waiting for the coffee to finish.

"You're very tactile," I observe.

"You're very touchable."

"That's not a defense."

"It's not meant to be." He pulls me closer, settling me against him while we wait for the ancient Mr. Coffee to complete its wheezing efforts. "Is it too much?"

I consider the question honestly. I've never been a particularly physical person. I hug my brother, occasionally. I allow Gloria's hand on my shoulder when she's being maternal. Beyond that, I exist in a bubble of professional distance that I've never particularly wanted to breach.

But Sam's hands on me feel like information. Like he's learning a language, and my body is the text.

"No," I say. "It's not too much."

The coffee maker gurgles its final death rattle, and Sam releases me to pour two cups. His kitchen is a revelation. There are no fewer than four half-finished projects on the counter alone: a disassembled blender, something that might be a motor, a pile of what appears to be children's bicycle parts, and a 3D-printed prototype of something I can't identify.

"Where do you cook?"

"Cook?" He says it like I've asked where he performs surgery.

"Yes, cook. The process by which raw ingredients become food."

"Oh." He looks around his kitchen with the air of a man seeing it for the first time. "I don't, really. There's a great taco truck two blocks down. And Elena brings food sometimes, because she thinks I'll starve. Which is a legitimate concern, I'll admit."

"Sam."

"Yes?"

"There's a soldering iron next to your toaster."

"That's not,okay, it's exactly what it looks like, but I was very careful about cleanup."

I pick up my coffee and take a long sip. It's surprisingly good, rich and dark, which makes me wonder if the dying Mr. Coffee has been judged unfairly.

"Where did you learn to make coffee like this?"

"Colombia." He says it casually, like it's not a revelation. "I spent six months there after college, working on a water filtration project. The coffee ruined me for everything else. I have beans shipped from a farm outside Medellín."

"You import coffee beans from Colombia."

"Yes."

"But you own flannel pillowcases and a soldering iron next to your toaster."

"I contain multitudes." He grins. "Also, flannel is comfortable year-round, and I already told you I was careful about the soldering iron."

I want to argue, but he's making a face at me over his coffee cup,this deliberately innocent expression that's completely transparent,and I find myself laughing instead. It comes out louder than I expect, startling both of us.

"There it is," Sam says, delighted. "That's become my favorite sound."

"I laugh all the time."

"You do not."

"I do! I laugh at Marco's jokes. I laugh at," I try to think of other examples. "Things."

"Things," he repeats. "Very convincing."

"I'm a very funny person."

"You're a very *serious* person who occasionally says devastatingly funny things with complete deadpan delivery." He sets down his coffee cup and crowds me against the counter,the only section not occupied by project debris. "It's one of my favorite things about you."

"You have favorite things about me?"

"I have a list."

"Of course you do."

"It's color-coded."

I can't tell if he's joking. With Sam, this is often the case. "Show me."

"Absolutely not." He kisses my forehead, which is annoyingly endearing. "A man has to maintain some mystery."

---

I need to go home eventually. I have work tomorrow, clothes at my apartment, a life that exists outside this bubble of flannel pillowcases and imported coffee and Sam's hands finding reasons to touch me every thirty seconds.

But first, he wants to show me the workshop.

"It's Sunday," I point out. "Nobody's there."

"That's why it's perfect." He's already pulling on shoes, moving with the barely contained energy I've come to recognize as his default state. "I can give you the real tour. Not the investor version,the actual space."

The investor version. Right. There's a reason I know the Mobility Workshop floor plan, and it's not because I've been dating Sam. It's because I spent three weeks analyzing the company for Harrison Webb, and my due diligence report was thorough enough to include square footage.

I decide not to mention this. There are limits to how much professional overlap one new relationship can handle.

The workshop is different on a Sunday. When I came before,in my professional capacity, wearing my armor and my sensible heels,the space was alive with people. Technicians at workbenches, someone testing a motorized chair in the open floor space, music playing from a speaker someone had mounted on the ceiling.

Now it's quiet. Sunlight streams through the industrial windows, catching motes of dust suspended in the air. The equipment sits dormant, waiting.

"This is where the magic happens," Sam says, and then immediately winces. "That was terrible. Please forget I said that."

"Already forgotten."

"You're lying."

"I'm absolutely lying. I'm going to bring it up at least six more times."

He laughs and takes my hand, leading me between workbenches. His tour is nothing like the polished presentation I witnessed during due diligence. Instead, he stops at seemingly random points to tell me stories: this is where Javier accidentally set off the fire suppression system, this is the workbench where they built the first prototype that actually worked, this corner is where Elena cried when she saw the final design of her custom chair.

"She was so mad," Sam says, grinning at the memory. "She hates crying in front of people. But she couldn't help it. The chair was everything she'd described and a few things she hadn't thought to ask for. I'd been sketching ideas since I was seventeen."

"You designed your sister's wheelchair when you were seventeen?"

"I designed my sister *a* wheelchair when you were seventeen. It was terrible. The turning radius was a joke, and it kept pulling to the left. But Elena used it anyway, because she's stubborn and she wanted to support me." He runs his hand over a workbench, memory in the gesture. "The one she uses now is version twelve. We finally got it right."

I think about my own seventeen. I was studying for the SATs, already planning my path to law school, already building the Berna who could survive anything. I wasn't designing anything for anyone. I was just trying to get out.

"You're doing the thing," Sam says.

"What thing?"

"The thing where you go inside your head and I can't follow." He squeezes my hand. "Where'd you go?"

"Nowhere interesting. Just thinking about being seventeen."

"What were you like at seventeen?"

"Determined." The word comes easily because it's true. "Scared. Convinced that if I could just work hard enough, control enough, plan enough,"

"Everything would be okay?"

"Everything would be *predictable*." I look around the workshop, at the organized chaos of creation. "It didn't work, obviously. Nothing is predictable. But I didn't learn that until much later."

Sam pulls me toward him, wrapping his arms around me from behind so we're both facing the open floor space. "For what it's worth," he says quietly, "I'm glad you learned it."

"Why?"

"Because predictable Berna probably wouldn't have kissed me in that doorway."

I lean back against him. "Predictable Berna definitely wouldn't have kissed you in that doorway. She would have maintained professional distance and filed you under 'attractive complications to be avoided.'"

"I would have made a move anyway."

"I know. You have no respect for professional boundaries."

"Zero." He kisses the side of my neck. "Complete and total disregard."

We stay like that for a moment, the workshop silent around us, Sunday light making everything soft. I could stay here, I realize. In this moment, in this bubble. It would be easy.

But then my brain, my inconvenient, overactive brain, does the thing it always does. It starts working.

"Sam?"

"Mm?"

"The CeraTest report. The one I included in my due diligence."

He stiffens slightly behind me. Not much, but enough. "What about it?"

"I've been thinking about it." I turn in his arms so I can see his face. "The numbers don't sit right with me. The endurance data looks perfect. Too perfect."

"Berna,"

"I know, I know. The engagement is over. Whatever decision Harrison made, my work is done." I pause. "But something's off. I can feel it."

His expression is carefully neutral, which is how I know I've touched a nerve. Sam's face doesn't do neutral. It does enthusiastic, frustrated, joyful, concerned,neutral is a foreign language he's speaking badly.

"The CeraTest materials were a huge selling point," he says slowly. "If there's a problem,"

"I'm not saying there's a problem. I'm saying the data looks too clean." I step back, because I need space to think and his proximity is distracting. "When's the last time you ran independent verification?"

"We ran tests during development. The results were consistent with the supplier data."

"Consistent how?"

"Berna." His voice has an edge now. "It's Sunday. We just,I thought we could have one day before work stuff,"

"This isn't work stuff." I regret the words as soon as I say them, because they're not entirely true. "Okay, it's partially work stuff. But it's also you stuff. Your company. Your reputation. If there's an issue with your materials and it comes out later,"

"It won't come out later because there's no issue."

"You don't know that."

"I trust my supplier."

"Trust isn't verification."

We're staring at each other now, and I realize this is our first real disagreement. Not playful bickering about pillowcases, not the professional sparring of our early meetings. An actual difference of opinion where neither of us is backing down.

"I'll look into it," Sam says finally. "Monday. I'll pull the original test data and compare it to the supplier specs."

"I can help,"

"Berna." He reaches out, takes my hand again. The gesture feels deliberate, a bridge over whatever tension just rose between us. "I appreciate that your brain never stops. I do. It's one of your best features. But can we have one morning where you're not working?"

I open my mouth to argue,I'm not working, I'm just thinking, which is different,but then I look at his face and see the exhaustion beneath the patience. Sam has been fighting for this company for years. He's been fighting for funding, fighting skeptics, fighting a market that wants to put disabled people in whatever mass-produced chair is cheapest.

He doesn't need me to find problems. Not today. Not right now.

"Fine," I say. "One morning."

His relief is visible. "Thank you."

"But Monday,"

"Monday you can cross-examine all the data you want." He pulls me back toward him. "Today, you're just my girlfriend, and I'm giving you a tour."

My girlfriend. The phrase still lands strangely, like a shoe that doesn't quite fit but might with breaking in.

"Fine," I say again. "Show me more things."

---

We end up at Elena's apartment because Sam promised to help her with something, and I've been demoted from professional acquaintance to "person who's been sleeping with my brother," which apparently requires a whole new level of scrutiny.

"Sit," Elena says, pointing at her couch. It's an order, not a request.

Sam has disappeared into the bathroom with what I think are plumbing tools but might also be a robot,with Sam, it's genuinely hard to tell. This leaves me alone with his sister, who is looking at me with an expression I can only describe as judicial.

"So," she says.

"So," I agree.

"You're the lawyer."

"I'm a lawyer, yes."

"The one who was evaluating Sam's company for the investor."

"That's accurate."

"And now you're sleeping with him."

I consider my options. Deflection seems pointless; Elena clearly values directness. Denial is impossible; Sam has a hickey on his neck that I noticed approximately three seconds too late to do anything about.

"Yes," I say. "I am."

Elena's eyes narrow. "The investor situation,"

"Has been resolved. My professional engagement with Mobility Workshop has concluded. Any relationship I have with Sam at this point is personal and presents no conflict of interest."

She blinks at me. Then, unexpectedly, she laughs. "God, you really are a lawyer."

"I've been accused of worse."

"I bet you have." She wheels closer, and I notice for the first time that her chair is beautiful,sleek lines, a purple frame that matches the streak in her hair, controls that look custom. Sam's work. The twelfth version. "Look, I don't care about the professional stuff. Sam's a big boy; he can handle his own business."

"Then what do you care about?"

"Whether you're going to break his heart."

The directness startles me. I'm used to polite evasions, the professional dance of implications and insinuations. Elena skips all of it and goes straight for the throat.

"I don't intend to."

"Nobody intends to." She shrugs. "But Sam,he doesn't do casual. He doesn't do provisional or contingent or whatever lawyer word you'd use. He's all in, every time. It's his best quality and his worst."

"I know."

"Do you?" She studies me, and I have the uncomfortable feeling of being deposed by someone far more skilled than most opposing counsel. "Because the way he looks at you,he's already all in. You could destroy him."

I think about this. About Sam's face when I walked into that first meeting, the way his expression shuttered and then softened. About the balcony conversation and the sushi dinner and every moment since where he's let me see him, really see him, without armor or pretense.

"I could," I agree. "But I won't."

"How do you know?"

"Because I'm all in too." The words come out before I can sensor them, before I can wrap them in qualifiers and conditions. "I just don't know how to show it the way he does. I'm,not good at this. Relationships. Feelings. The whole messy, terrifying, uncontrollable aspect of wanting someone."

Elena is quiet for a moment. Then she smiles, and it transforms her face from sharp to warm. "You know what? I believe you."

"You do?"

"Anyone who describes wanting my brother as 'terrifying and uncontrollable' is taking it seriously." She wheels back, giving me space. "Welcome to the family, I guess. We're chaotic and we have weird attachment issues and Sam will never stop trying to fix things for people whether they want him to or not."

"I've noticed."

"The fixing thing?"

"All of it."

There's a crash from the bathroom, followed by Sam's voice: "That was intentional!"

Elena and I look at each other. Something passes between us,understanding, maybe. The beginning of an alliance.

"He's going to flood my bathroom," she says.

"Probably."

"Should we stop him?"

"Can anyone stop Sam when he's determined to fix something?"

Elena grins. "I like you, Berna. Even if you did try to sink my brother's company."

"I didn't try to sink,"

"I'm kidding." She waves a hand. "Mostly. Go save him from my plumbing before he causes structural damage."

I go. Sam is standing in two inches of water, holding what appears to be a pipe wrench in one hand and a piece of rubber tubing in the other. He looks up when I appear in the doorway, expression oscillating between sheepish and defiant.

"I can fix this."

"I believe you."

"It looks bad."

"It looks very bad."

"But I can fix it."

I step into the water,there goes my one pair of non-work shoes,and take the pipe wrench from his hand. "Show me what you need."

His face does something complicated. Then he smiles, and it's the same smile from this morning, from the workshop, from every moment where he's looked at me like I'm a puzzle he's delighted to solve.

"Hold this here," he says, guiding my hands into position. "And don't let go."

I don't.

---

We fix the pipe. It takes an hour, two YouTube tutorials, and a brief but heated debate about the tensile strength of Teflon tape, but we fix it. By the end, I'm soaked from the knee down, Sam has grease on his forehead somehow, and Elena has made us sandwiches because she says we look "like drowned engineers."

"I'm not an engineer," I point out.

"You argued about tensile strength for fifteen minutes. You're an honorary engineer now." She shoves a sandwich toward me. "Eat. You're too skinny."

"She's not skinny," Sam says. "She's,"

"If you finish that sentence, I'll make you fix the garbage disposal too."

Sam shuts his mouth.

I eat my sandwich,roast beef, excellent bread, some kind of spicy mayo that I need the recipe for,and watch them bicker. The easy rhythm of siblings who know each other too well, who've weathered things together. I think about Marco, about our own complicated relationship, about what it means to have someone who knew you before you became yourself.

My phone buzzes in my pocket. Work email, probably. Or Marco checking in. Or,

I pull it out and my stomach drops.

It's a Google alert. I set them months ago, standard practice for any company I'm evaluating. "CeraTest composite materials" and "Mobility Workshop" and "Harrison Webb." Most of them have been useless,press releases, industry news, nothing important.

This one is different.

**CeraTest Faces Questions Over Material Testing Standards**

I scan the article quickly. An industry publication, not mainstream news. Questions raised by a competitor about CeraTest's quality control procedures. Nothing definitive, nothing damning. Just questions.

But questions, in my experience, are how everything starts.

I look at Sam, who's laughing at something Elena said, grease still on his forehead, completely unaware. I think about the too-perfect data, the supplier trust he's built his company on, the beautiful products he makes for people who need them.

I should say something. Now, today, before this grows into anything bigger.

But he asked for one morning. One morning where I'm just his girlfriend and not a lawyer with questions.

I put my phone away.

"Everything okay?" Sam asks, catching my expression.

"Fine," I lie. "Just work stuff."

He accepts this because he has no reason not to. Because we're still new, still learning, still building the vocabulary of trust.

Tomorrow, I tell myself. Tomorrow I'll dig deeper, verify everything, figure out what's real and what's paranoia.

Today, I'm just his girlfriend.

The word is starting to fit better. I'm not sure if that makes me happy or terrified.

Both, probably. Both at once.

---

That night, back at my apartment, I fall asleep with my phone in my hand. I'm researching CeraTest, following threads that might lead somewhere or nowhere, building a case that might not need building.

Sam texts at eleven: *Missing you already. Your pillowcases are probably more comfortable but mine have better company.*

I type back: *Your pillowcases are flannel. Thread count: unknown. I maintain that this is unacceptable.*

*And yet you slept great.*

He's not wrong. I did sleep great. Better than I have in months, maybe years. Like my body finally got permission to stop being vigilant.

*Goodnight, Sam.*

*Goodnight, girlfriend.*

I put the phone down. The CeraTest tabs are still open on my laptop, questions multiplying in the dark.

Tomorrow.

Everything can wait until tomorrow.

$akm001ch11$,
  3729
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  12,
  'Chapter 12: The Weight of What I Know',
  $akm001ch12$
# Chapter 12: The Weight of What I Know

The coffee maker gurgles its morning song while Sam moves through his kitchen with the ease of someone who's done this a thousand times. Except now there's a second mug on the counter. A specific mug,the one with the chipped handle that he pulled from the back of his cabinet three weeks ago and hasn't put away since.

It's mine now. The thought catches me off guard, how quickly objects accumulate meaning.

"You're staring at the coffee maker like it owes you money," Sam says, sliding behind me. His arms wrap around my waist, his chin finding the curve of my shoulder. The stubble on his jaw scratches pleasantly against my neck.

"I'm thinking."

"Dangerous." His lips press against the spot just below my ear. "About what?"

About the Google Alert sitting unread in my email. About CeraTest and testing standards and the cold knot that formed in my stomach yesterday when I saw those words. About how I chose *tomorrow* and tomorrow is here and I still don't want to say anything.

"About how you make terrible coffee," I say instead.

"Excuse me?" He pulls back in mock offense. "My coffee is exceptional."

"Your coffee tastes like someone described coffee to you and you tried to recreate it from memory."

"That's incredibly specific slander."

I turn in his arms, facing him. He's wearing a soft gray t-shirt that's seen better days and sweatpants that hang low on his hips, and his hair is doing something architectural that defies explanation. He looks ridiculous and perfect and mine.

The word keeps landing differently now. *Mine.* Not possession but partnership. Not ownership but belonging.

"I'll make the coffee from now on," I tell him. "Non-negotiable."

"See, this is why the girlfriend thing is working out. Division of labor."

"Is that what this is? Efficient resource allocation?"

His grin spreads slow and warm. "Among other things."

He kisses me, morning breath and all, and I let myself sink into it. Let myself have this moment before the day starts, before the emails and the obligations and the thing I'm not saying crowds back in.

---

The workshop is different on a Tuesday morning than it was the night I first came here. Sunlight streams through the high windows, catching dust motes that drift lazy through the air. The industrial space feels almost domestic with people moving through it,Petra at her welding station, Marcus bent over his laptop in the corner office, two other employees whose names I've learned and forgotten twice.

I'm here because my apartment has a water leak. That's the official reason. The actual reason is that Sam asked if I wanted to work from his office today and I said yes before he finished the question.

"The WiFi password is 'RollingThunder' all one word," Sam calls from across the floor where he's examining something with Petra.

"Seriously?"

"Elena picked it when she was fourteen. I'm sentimental."

I settle into a corner of his glass-walled office, laptop open, trying to focus on the Westfield contract revisions while the workshop hums around me. Sam moves through the space like he belongs to it,which he does, I remind myself. He built this. Every station, every process, every person here exists because he decided it should.

I watch him crouch next to a partially assembled wheelchair frame, gesturing at something while Petra nods. His hands move when he talks, shaping ideas in the air. He laughs at something she says, head thrown back, completely unselfconscious.

This is him in his element. Not the chaos of the day we met, not the contained version who sits across from me at restaurants. This is Sam at full volume, filling the space he's created.

My phone buzzes. Gloria.

*Dev Chen from Webb Capital called. Wants to discuss CeraTest testing timeline. Call me.*

The name doesn't register at first. Then it does,Harrison Webb's junior partner. The one who's been copied on emails but never appeared in meetings. The one Sam mentioned once, dismissively, as "Webb's attack dog."

I should call Gloria back immediately. Instead, I open the Google Alert I've been avoiding since yesterday.

*CeraTest Faces Questions Over Material Testing Standards*

The article is from a biomedical industry publication, not mainstream news. But the details make my stomach clench. An independent researcher flagged inconsistencies in CeraTest's published testing methodology. Questions about sample sizes. Concerns about accelerated aging protocols that may not accurately predict real-world material performance.

Nothing definitive. No smoking gun. Just enough smoke to suggest fire.

I scroll to the comments section,always a mistake, always irresistible. Mostly industry professionals debating the merits of different testing approaches. One commenter claims CeraTest's methodology is "standard for the field." Another calls it "barely above undergraduate thesis work."

"You look like you're reading something terrible."

I slam my laptop closed before I can stop myself. Sam is leaning in the office doorway, two mugs in his hands.

"Contract issues," I say, too fast. "Westfield is being difficult about the liability language."

"Shocking. A corporation being difficult about liability." He hands me one of the mugs. It's not the coffee I made this morning,it's tea, Earl Grey, prepared the way I drink it. "Petra made this. She's better at hot beverages than I am, apparently."

"She's better at most things than you are. You just happen to own the building."

"Brutal." But he's smiling. "I have to run to Pacific Mobility to check on the joint venture paperwork. Hour, maybe two. You good here?"

"I'm good."

He leans down to kiss me, quick and easy, like we've been doing this for years instead of weeks. "There's food in the break room fridge. The leftover Thai is mine, but you can have the questionable pasta salad."

"Generous."

"I'm a giver."

He's gone before I can say anything else, the workshop door swinging shut behind him. I watch through the window as he crosses the parking lot, phone already pressed to his ear, moving with that restless energy that never quite settles.

I open my laptop again. The article is still there, waiting.

---

Gloria answers on the second ring. "Berna. I was about to send a search party."

"I was reading something. What did Dev Chen want?"

"He wants a meeting. Tomorrow. Here at the office." A pause weighted with meaning. "He wants to discuss 'concerns that have come to his attention' regarding the CeraTest certification."

The knot in my stomach tightens. "What kind of concerns?"

"He didn't specify. But he was very clear that this is a preliminary conversation, not an official inquiry." Another pause. "Berna, is there something about this deal I should know?"

There are several things she should know. There's the article. There's my growing unease about the testing methodology. There's the fact that I've been sleeping with our client for weeks and have developed feelings that compromise my professional judgment in ways I can barely articulate.

"Nothing concrete," I say. "But I've seen some industry chatter. Questions about CeraTest's testing protocols."

"What kind of questions?"

"Methodology concerns. Sample size issues. Whether their accelerated aging protocols accurately predict long-term material behavior."

Silence on Gloria's end. I can picture her in her corner office, fingers steepled, calculating.

"Have you brought this to Sam?"

"Not yet."

"Why not?"

Because I don't want to. Because it might not be real. Because if it is real, it changes everything, and I'm not ready for everything to change.

"I wanted to verify first," I say. "It's just blog posts and comment sections right now. I didn't want to alarm him over nothing."

"Dev Chen calling for a meeting suggests it's not nothing."

"I know."

Gloria sighs. The sound carries years of partnership politics and client management and deals that went sideways. "Get ahead of this, Berna. If there's a real issue with the certification, Sam needs to know before Webb Capital does."

"I will."

"Today."

"I understand."

She hangs up without saying goodbye. Standard Gloria.

I stare at my phone for a long moment, then open my browser and start searching.

---

The research takes two hours. By the end, my eyes ache and my tea is cold and I have seventeen tabs open across three browsers.

Here's what I know:

CeraTest Labs is a mid-tier materials testing facility based in San Jose. They've been in business for eight years, handling certifications for various biomedical applications. Their client list includes several mobility device manufacturers.

Here's what's concerning:

Their accelerated aging methodology uses a thermal cycling protocol that several independent researchers have questioned. The concern is that it doesn't adequately account for the specific stress patterns of mobility devices,the torque on joints, the pressure points at connections, the accumulated micro-fractures from daily use.

In 2024, a wheelchair manufacturer in Ohio recalled 3,000 units after their certified frame material developed hairline cracks at stress points. The certification had been done by a facility using similar protocols to CeraTest.

Here's what I don't know:

Whether Sam's glaze formula is affected by these specific concerns. Whether CeraTest's methodology is actually inadequate or just unconventional. Whether any of this rises to the level of a genuine safety issue or just academic debate.

But I know this: the gap between "definitely safe" and "probably fine" is a gap I'm not comfortable with. Not for mobility devices. Not for the people who depend on them.

Not for Elena.

The thought hits me like a physical blow. Elena in her purple wheelchair, asking me whether I trust Sam. Elena who uses equipment like this every day of her life. Elena who would be exactly the kind of person affected if something went wrong.

I close all the tabs. I can't look at them anymore.

---

Sam returns at noon, flushed with cold air and carrying a bag from the sandwich place on Division Street.

"I brought sustenance," he announces, dropping into the chair across from me. "Also news. Pacific Mobility is on board. Full commitment. They want to start integration planning next month."

"That's great." My voice sounds strange to my own ears. Hollow.

Sam notices immediately. His expression shifts, the easy joy dimming. "What's wrong?"

"Nothing's wrong."

"Berna." He says my name like it's a complete sentence. A request and a statement and a question all at once.

I should tell him now. This is the moment. The office door is closed, we're alone, I have all the information organized in my head. Professional and clean and manageable.

Instead, I say, "Can we go somewhere? Not here."

He studies me for a long moment. Whatever he sees in my face makes him nod, set the sandwiches aside, stand without asking anything else.

"The roof," he says. "Come on."

---

The roof is not what I expected. It's a hidden garden, improbably, maintained in container beds along the building's edge. Even in February, there's green here,kale plants and winter herbs and something that might be chard, protected by makeshift cold frames made from old windows.

"Elena started it," Sam explains, leading me to a bench facing west toward the hills. "Three years ago. She said if I was going to make her come to the workshop every time she wanted to yell at me about something, there should at least be somewhere nice to do it."

The city spreads below us, gray and green under a thin winter sun. The air is sharp and clean and my lungs ache with the cold.

We sit. Sam waits.

This is the thing about him that undoes me most,his willingness to wait. To make space. To let silence stretch until I'm ready to fill it.

"I got an alert yesterday," I start. "About CeraTest. There's an article,"

"I know."

I turn to look at him. His face is calm, but there's something under it. Something I haven't seen before.

"You know?"

"Marcus flagged it this morning. I've been reading up." He runs a hand through his hair, that nervous tell I've learned to recognize. "There are questions about their methodology. Accelerated aging protocols, sample sizes. Whether the testing adequately captures real-world stress patterns."

"And?"

"And I don't know yet." He exhales, long and slow. "I've got calls out to two independent materials scientists. One of them consulted on the glaze formula originally. I should have answers by end of week."

Relief washes through me,he knows, he's handling it, I don't have to be the one to tell him,followed immediately by a different kind of dread. Because if he knows and he's handling it, then the article is real. The concerns are legitimate. This isn't just industry gossip.

"There's more," I say. "Dev Chen called Gloria this morning. He wants a meeting. Tomorrow. He wants to discuss 'concerns' about the certification."

Sam goes very still. "Webb's guy."

"Harrison's junior partner. Yes."

"How did he hear about this?"

"I don't know. The article's been out for a day. Maybe he has the same Google Alerts we do."

Sam stares out at the city. His jaw is tight, the tension visible in the cords of his neck. This is his fear, I realize. This is the thing underneath the chaos and the confidence. Not failure in the abstract,failure that hurts people. Failure that proves him wrong about himself.

"If the glaze isn't safe," he starts.

"We don't know that yet."

"If it isn't safe," he repeats, quieter, "then everything I've been telling Elena, telling myself, about why this matters,"

"Sam."

"She trusts me." His voice cracks on the word. "She believes in what I'm building. If I put something on the market that hurts people like her,"

I reach for his hand. His fingers are cold, rough-skinned from the workshop. He grips back hard enough to hurt.

"That's why we check," I say. "That's why we investigate. That's why you're not signing anything until you have answers."

"Harrison is going to kill this deal."

"Maybe."

"If the certification is compromised, Webb Capital walks. The entire investment collapses. Everything I've built,"

"Stops being built by other people's money and starts being built slower, by yours."

He looks at me then. Really looks, like he's seeing something he didn't expect.

"You should be worried," he says. "This is your deal too. Your career."

"I know."

"But you're not telling me to spin this. To find a narrative that protects the timeline."

"No."

"Why?"

Because I have a brother who told me never to compromise. Because Gloria asked me once what kind of lawyer I wanted to be. Because Elena asked if I trusted Sam, and I said yes, and I need that yes to mean something.

"Because if the glaze isn't safe," I say, "then we need to know that more than we need to close this deal. And if it is safe, then the investigation proves it and everyone relaxes."

Sam exhales something that might be a laugh. "You're too good for this industry."

"I'm exactly good enough for this industry. That's the problem."

He turns to face me fully, his hand still in mine. The winter light is harsh on his face, showing every line, every exhaustion. He doesn't look like the confident founder I met three months ago. He looks scared.

"I love you," he says.

The words land like a physical thing,in my chest, in my throat, somewhere behind my eyes. Not the cinematic declaration of movies. Just truth, simple and terrifying, spoken by someone who is afraid and saying it anyway.

"I love you," he repeats, stronger. "I don't know if this is the right time to say it, with everything else happening. But I need you to know. Whatever happens with Webb, with the deal, with any of it,this is real. You're real. I'm not going to let the other stuff take that away."

I lean forward and kiss him. His lips are cold from the air, his cheeks rough with stubble he hasn't shaved in two days. He tastes like coffee and fear and something underneath that I don't have a word for.

"I love you too," I say against his mouth. "Even though your coffee is terrible."

He laughs, wet and rough, and pulls me against his chest. I press my face into the hollow of his shoulder, breathing in the smell of him,workshop oil and wool and something that's just Sam, specific and irreplaceable.

His arms tighten around me. My face against his chest, feeling his heart beat through the layers of fabric. The specific comfort of being held by someone who knows you and chooses to hold you anyway.

This is the peak, I think. This is the top of the roller coaster, the moment before the drop. I should memorize it. The quality of the light, the pressure of his arms, the way his heartbeat sounds against my ear.

We stay like that for a long time. The city spreads silent below us, February cold seeping through our coats. Neither of us moves.

---

The meeting with Dev Chen is at two o'clock the next day.

I arrive at Hanover & Pryce early, armed with a folder of documentation and a mind that hasn't stopped racing since yesterday. Sam texted at midnight,the materials scientist hadn't called back yet, the other one wanted more information before committing to a consultation.

We're going into this meeting blind. I hate going in blind.

Dev Chen is not what I expected. He's younger than Harrison,early thirties, maybe,with sharp cheekbones and a tailored suit that probably cost more than my monthly rent. His handshake is firm and brief, his smile practiced.

"Ms. Alvarez. Thank you for making time."

"Of course, Mr. Chen. Gloria sends her apologies,she had a conflict she couldn't move."

Gloria has no conflict. Gloria is letting me handle this alone because it's my client, my deal, my responsibility. Standard Gloria.

We settle into the small conference room. Dev opens a leather portfolio with Webb Capital's logo embossed on the cover.

"I'll be direct," he says. "We've become aware of concerns about CeraTest Labs' testing methodology. Specifically, their accelerated aging protocols for biomedical applications."

"We've seen the same article," I say. "Sam is consulting with independent materials scientists to verify the certification's validity."

"That's good to hear." Dev's expression doesn't change. "However, Webb Capital has additional concerns."

"Such as?"

He slides a document across the table. It's a printout of an email, heavily redacted but with enough visible to make my stomach drop.

"We received this anonymously two days ago," Dev says. "It suggests that CeraTest's internal review flagged potential issues with their testing methodology eighteen months ago. Issues that were not addressed in their published protocols."

I look at the email. The sender is redacted, the recipient is redacted, but the body is damning: *"...concerns raised in Q3 review not implemented... decision to proceed with existing methodology... client timeline pressures..."*

"Where did you get this?"

"As I said, anonymously."

"And you can't verify its authenticity."

"We can't verify its authenticity," Dev agrees. "But we also can't proceed with a significant investment while questions like these remain open."

The floor tilts beneath me. This is it,the pivot, the moment where everything changes.

"What are you proposing?"

Dev closes his portfolio. "Webb Capital is pausing the investment pending independent verification of the SynaptiGlaze certification. We're recommending a full re-test by an accredited facility of our choosing."

"That could take months."

"Six months, minimum. Possibly longer."

Six months. The Pacific Mobility deal would collapse. The expansion timeline would be destroyed. Everything Sam has built toward would stall indefinitely.

"I need to discuss this with my client," I say.

"Of course." Dev stands, extending his hand again. "We're not adversaries here, Ms. Alvarez. We want this investment to succeed. But we want it to succeed on solid ground."

He leaves. I sit alone in the conference room, staring at the redacted email, feeling the weight of everything I know pressing down on my chest.

---

I call Sam from my car in the parking garage. The concrete walls make my voice echo strangely.

"How bad?" he asks.

"Bad." I summarize the meeting, the anonymous email, the six-month pause.

Silence on his end. Then: "Someone inside CeraTest leaked this."

"Maybe. Or someone wanted Webb to think someone inside CeraTest leaked this."

"Does it matter?"

I stare at the concrete wall in front of me, gray and cold and impersonal. "It matters for figuring out what's actually true. Someone sent that email to Webb for a reason. We need to know if it's real or if it's sabotage."

"And if it's real?"

"Then we have bigger problems than the investment timeline."

Another silence. I can hear him breathing, can picture him pacing his office, running his hand through his hair.

"Come over tonight," he says finally. "Not to work. Not to strategize. Just,come over."

"Okay."

"I love you."

The words still land like something physical. Like a hand on my chest, steady and present.

"I love you too," I say.

I hang up. The parking garage is silent around me, cold and echoing and empty. Somewhere above me, the city keeps moving,people with problems that aren't mine, lives that aren't entangled with testing protocols and investment timelines and the specific weight of knowing something I wish I didn't.

I start my car. I drive.

The thing about pivots is that you don't always recognize them while they're happening. Sometimes you only see them looking back, connecting dots that seemed random at the time.

But I recognize this one. I feel the floor tilting, the trajectory changing. Everything that comes after will be shaped by what happened in that conference room, what was in that email, what we decide to do next.

I love him. He loves me. And somewhere in the gap between CeraTest's methodology and the truth, something is waiting that we can't see yet.

Tomorrow, we investigate.

Tonight, we hold on.

$akm001ch12$,
  3645
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  13,
  'Chapter 13: Material Failure',
  $akm001ch13$
# Chapter 13: Material Failure

The independent materials report arrived at 6:47 AM.

I was already awake. Sleep had become a negotiation these past few days,four hours here, three there, my body refusing to fully surrender while the CeraTest situation hung unresolved. Sam was the opposite. He slept hard and deep when he finally let himself, his body's way of conserving energy for the fight. I'd watched him last night, his face slack and young in the dim light from the street, and felt something sharp lodged between my ribs that wouldn't dissolve.

My phone buzzed on the nightstand. Email notification. The lab Sam had hired,Patterson Materials Testing out of Berkeley, impeccable credentials, no connection to either CeraTest or Mobility Workshop. The gold standard of independent verification.

I should have waited. Should have let Sam see it first. It was his report, his company, his crisis.

But my name was on the engagement letter. My firm had facilitated the introduction. And somewhere in the legal portion of my brain that never fully shut off, I knew I needed to see this before anyone else did.

I slipped out of bed without waking him. His apartment was cold in the early morning, February light just starting to gray the windows. I took my phone to the kitchen, made coffee I wouldn't drink, and opened the attachment.

Twelve pages. Technical specifications, test methodologies, comparative analysis. I scrolled past the executive summary,lawyers always do, we don't trust summaries written by other people,and went straight to the data tables.

The numbers didn't lie.

CeraTest's proprietary glaze compound showed measurable degradation under sustained heat exposure. Not at the levels they'd tested to originally,their own documentation was technically accurate. But at temperatures that occurred in real-world use. Equipment cleaning cycles that ran hotter than standard protocols. Vehicles and outdoor environments during summer heat. The kind of edge cases that users created every day without thinking about it.

The degradation rate was slow. Cumulative. The kind of thing that wouldn't show up in a standard product test but would absolutely matter over three years of daily use.

And the degradation products included trace amounts of cadmium.

Not enough to cause acute poisoning. The report was clear about that. But enough to exceed EPA safety thresholds for cumulative exposure. Enough that labeling requirements would kick in. Enough that products in the market might need to be recalled.

Enough that this was no longer a dispute about documentation standards.

This was a real problem.

I read the section on degradation byproducts three times, hoping I'd misunderstood the chemistry. But Patterson's conclusion was unambiguous: *The proprietary glaze compound demonstrates concerning stability characteristics under high-temperature cycling conditions. We recommend against extended direct-contact applications pending reformulation of the base matrix.*

Against extended direct-contact applications.

Mobility Workshop's entire medical device line used CeraTest coating.

I sat with the report for twenty minutes, watching the sky lighten over Portland's east side. Across the apartment, I could hear Sam starting to stir,the creak of bedsprings, a muffled sound that might have been my name.

For one terrible moment, I considered not telling him.

Not lying. Never that. But maybe... delaying. Maybe waiting until we'd had breakfast, until he was fully awake, until I could frame it in a way that didn't feel like I was dropping a grenade into his lap before he'd even had coffee.

The thought lasted exactly three seconds before professional ethics kicked in. There was no version of this where waiting was acceptable. The report existed. I had read it. Every hour I didn't disclose was an hour I was complicit in information asymmetry.

God, I hated my job sometimes.

"Berna?" Sam's voice from the bedroom, roughened with sleep.

"Kitchen," I called back. My voice sounded strange. Too controlled.

He appeared in the doorway a minute later, wearing the same gray t-shirt he'd slept in, his hair flat on one side and chaotic on the other. The sight of him,rumpled and unsuspecting,made my chest ache with something that felt like preemptive grief.

"You're up early." He came toward me, reaching for the coffee pot, then registered my expression. His hand stopped mid-reach. "What happened?"

"The Patterson report came in."

His whole body changed. The sleepy looseness dropped away, replaced by the focused tension I'd seen in him during every crisis meeting. He didn't ask to see it. He just waited, his eyes on my face, reading what the report said from my expression.

"Tell me," he said quietly.

So I did.

I walked him through the technical findings,the degradation rates, the temperature thresholds, the byproduct analysis. I showed him the data tables, the methodology section, the conclusions. I kept my voice steady and professional because that was the only way I could get through it.

When I finished, Sam was very still.

"Cadmium," he said.

"Trace amounts. Cumulative exposure."

"But measurable."

"Yes."

He turned away from me, both hands flat on the counter, his shoulders rigid. I watched him process it,watched the implications cascade through him the way they'd cascaded through me twenty minutes earlier.

Elena uses these products.

His sister, who'd inspired everything he'd built, who'd been using Mobility Workshop devices for years. The coating on her wheelchair components. The grips on her adaptive equipment. All of it treated with CeraTest's proprietary glaze.

"The exposure levels in the report," he said, his voice careful, controlled. "What's the actual risk?"

"For someone using the products as intended, probably minimal. The degradation is slow, the amounts are trace. But,"

"But it exceeds regulatory thresholds."

"Yes."

"So it's a labeling issue."

"It's more than labeling." I made myself say it. "Products already in the market would need to be assessed for recall. Future production would need to stop pending reformulation. And any company that continued manufacturing with full knowledge of these results,"

"Would be liable."

"Criminally, potentially."

Sam laughed,a short, harsh sound that didn't have any humor in it. "So this is the scenario. This is exactly what I was afraid of."

"Sam,"

"I built a company to help people like my sister, and instead I might have been slowly poisoning them for years." His voice was flat. Devastated. "That's what you're telling me."

"The exposure levels are trace. The health impact is uncertain. We don't know,"

"We don't know because we never tested properly." He turned back to face me, and the look in his eyes was worse than anger. It was the look of someone watching their worst nightmare materialize in front of them. "We trusted CeraTest's documentation. I signed off on their results. I put my name on products that,"

He stopped. His jaw worked.

"This is exactly what was supposed to never happen," he said quietly. "Elena trusted me. Every customer who bought our products trusted me. And I failed them because I believed documentation that I should have verified independently years ago."

"You couldn't have known,"

"That's the defense of every company that hurts people, Berna." His voice was sharp. "We couldn't have known. We relied on supplier documentation. We followed industry standards. Meanwhile people are using our products every day and we,"

He broke off again, turning away. I watched him fight for control, watched the professional mask try to reassemble itself over the devastation underneath.

I wanted to go to him. Every instinct I had was screaming to cross the kitchen, put my arms around him, tell him it would be okay.

But I couldn't.

Because it might not be okay. And because I had a professional obligation that was already straining at the seams.

"I need to tell Gloria," I said.

Sam went very still.

"The firm facilitated the CeraTest engagement. We have exposure. And now I have information that," I stopped, reorganized my words. "I can't sit on this report, Sam. The ethical obligations are clear."

"I'm not asking you to sit on it."

"I know you're not. But I need you to understand that when I walk into Gloria's office with this, everything changes. For both of us."

He turned to look at me. The distance between us was maybe six feet,the width of his small kitchen,but it felt like miles.

"Because you're involved with me," he said flatly. "Because you can't be objective anymore."

"Because I should have flagged the conflict of interest months ago. Because I let this become," I gestured between us, helpless. "Whatever this is."

"Whatever this is." He repeated it back to me, and something in his voice made me flinch. "That's what we're calling it now?"

"Sam, that's not what I,"

"I told you I loved you four days ago. You said it back. We stood on my roof in the rain and," He stopped, his voice catching. "And now you're standing in my kitchen telling me our relationship is a professional liability."

"It's not about what it is. It's about how it looks."

"Right. Perception management. Because that's what matters here,not the actual truth of anything, but how it can be spun."

The bitterness in his voice landed like a physical blow. I deserved it. I knew I deserved it. But it still hurt.

"I am trying to protect you," I said carefully. "If I disclose everything now,the relationship, the timeline, the conflict,then whatever comes next is documented. Above board. If I try to hide it and it comes out later,"

"Then we're both damaged goods." He nodded, his expression cooling into something distant and professional. "I understand. You need to protect the firm's interests. That's your job."

"That's not,"

"It's fine, Berna." He held up a hand, stopping me. "Do what you need to do. I'll be dealing with the actual crisis,figuring out how to notify customers, how to manage a potential recall, how to tell my sister that the equipment she's been using for years might have been slowly leaching toxins into her system. You handle the legal optics. We'll stay in our lanes."

The coldness in his voice was worse than yelling would have been. Yelling I could have fought. This careful, professional distance,this was the wall going back up.

I watched it happen in real time. The man who'd held me on the rooftop, who'd said *I love you, I love you*, retreating behind the barrier that had protected him for so long.

"Sam," I said. My voice broke on his name.

He looked at me. For one second, I saw everything,the love, the fear, the devastation. All of it raw and real and right there on his face.

Then he shuttered it.

"You should get to the office," he said. "Talk to Gloria before this goes any further."

---

Gloria's office was immaculate as always,clean lines, neutral colors, everything precisely arranged. The morning light came through her windows at an angle that made the whole room feel like a deposition waiting to happen.

She was already at her desk when I knocked at 8:15. Early, but not unusually so. The partners at Hanover & Pryce had a complicated relationship with the concept of normal working hours.

"Berna." She looked up from her screen, reading something in my expression that made her set down her coffee. "Close the door."

I did.

"What happened?"

I laid out the situation systematically,the independent report, the degradation findings, the regulatory implications. I put the Patterson analysis on her desk and watched her read it with the same focused intensity I'd felt scrolling through it four hours earlier.

When she finished, she looked up at me.

"This is a significant liability issue," she said. "The engagement letter we drafted,"

"I know."

"The firm's exposure here,"

"I know."

Gloria set the report down. Her expression shifted into something I couldn't quite read. "What aren't you telling me?"

Here it was. The moment I'd been dreading since I walked out of Sam's apartment.

"I'm involved with Sam Reyes," I said. "Romantically. It started after the engagement was signed, but,"

"How long?"

"Two months. Roughly."

Gloria's face didn't change, but something behind her eyes went very still. "Define 'involved.'"

"We've been seeing each other regularly. Spending nights together. He told me he loved me four days ago. I said it back." I made myself hold her gaze. "I should have disclosed months ago. I didn't. That's on me."

Silence. The kind of silence that fills rooms and presses against eardrums.

"Let me understand this," Gloria said finally. "You've been conducting a romantic relationship with the founder of a company where Hanover & Pryce has significant engagement exposure. You've had access to privileged information on both sides. You've participated in strategic discussions knowing that your judgment was compromised by personal attachment."

Each sentence landed like a verdict.

"Yes," I said.

"And you didn't think this warranted disclosure at any point in the past two months?"

"I thought," I stopped. What had I thought? That we could keep it separate? That professional and personal existed in different universes? That love didn't create conflicts of interest?

"I don't know what I thought," I admitted. "I wanted to believe it didn't matter. That I could be objective. That my work product wouldn't be affected."

"Berna." Gloria's voice was quiet, but there was steel underneath it. "I have spent fifteen years building this firm's reputation for rigorous ethical standards. You know this. You've been part of it. You've helped draft the conflict-of-interest policies that you've now violated."

"I know."

"Was any of your work on this engagement compromised? The due diligence? The CeraTest assessment? The materials documentation review?"

The question hung in the air between us.

"I don't believe so," I said carefully. "But I can't be objective about my own objectivity. That's the problem."

"That is indeed the problem." Gloria stood, moving to her window. She looked out at the Portland skyline for a long moment, her back to me. "Everything you've done on this engagement is now suspect. Every conclusion, every recommendation, every piece of advice you've given Sam Reyes has to be reconsidered through the lens of your relationship."

"I understand."

"Do you?" She turned back to face me. "Because what I'm hearing is that you understood the rules, understood the stakes, and chose to ignore them because,what? Because you fell in love?"

The word hit different coming from Gloria. Smaller. Less like a revelation and more like an excuse.

"I didn't plan it," I said, knowing how weak it sounded.

"No one ever does. That's why we have policies,because no one plans to lose their judgment, and everyone does anyway." Gloria sat back down, her hands flat on her desk. "You're off this engagement, effective immediately. I'll be bringing Marcus in to review everything you've done and assess whether the firm needs to make disclosures to the client."

"Marcus hates me."

"Marcus is thorough. That's what matters right now." Gloria's expression softened slightly,just enough to remind me of the mentor she'd been before this moment. "I'm not going to fire you, Berna. Not today. But I need you to understand that what happens next depends entirely on what Marcus finds."

"And if he finds problems?"

"Then we have a different conversation."

I nodded. My throat felt tight. "What about Sam? The situation with CeraTest,he needs legal counsel on this. Real counsel, not me."

"I'll assign someone from the corporate practice. Someone who has no connection to you or to this engagement." Gloria paused. "Does he know you're here? That you're disclosing?"

"He knows I was coming to talk to you. He doesn't know what I was going to say."

"I see." Something complicated moved across Gloria's face. "For what it's worth,and this doesn't excuse anything,I've watched you these past months. You've seemed happier. More grounded. I assumed it was professional confidence, but now," She stopped herself. "It doesn't matter. Go home, Berna. Let Marcus do his work. And stay away from Sam Reyes until we sort this out."

"Stay away from him?"

"Any contact between you could be seen as coordination. Comparing stories. Managing the narrative." Gloria's voice was gentle but immovable. "I know that's not what's happening. But we have to manage the appearance as carefully as the reality. You know this."

I did know it. I'd counseled clients on exactly this scenario a hundred times. Don't contact witnesses. Don't discuss the matter with involved parties. Don't create any appearance of impropriety.

It just felt different when the witness was someone I loved.

"How long?" I asked.

"Until Marcus completes his review. A week, maybe two."

Two weeks without seeing Sam. Two weeks without touching him, talking to him, being in the same room with him. Two weeks while his company faced potential recalls and his sister faced uncertainty about her health and everything he'd built teetered on the edge of collapse.

Two weeks where I couldn't be there.

"I understand," I said, because there was nothing else to say.

---

I went home. Not to Sam's apartment,I couldn't face that, couldn't face him, couldn't figure out how to explain that seeing him now might make everything worse.

Instead I went to my own place, the apartment I'd barely used since this thing between us had solidified into something real. It smelled stale. Unlived in. I opened the windows and let February air flood through, even though it was cold enough to see my breath.

My phone buzzed. Sam.

*Did you talk to Gloria?*

I stared at the message for a long time.

*Yes,* I typed back. *I'm off the engagement. Marcus is reviewing everything.*

Three dots appeared. Disappeared. Appeared again.

*What does that mean for us?*

Us. Such a small word to hold so much weight.

*I can't see you,* I wrote. *Not until the review is complete. It would look like coordination.*

The dots again. Longer this time.

*You're serious.*

*I have to be.*

Silence. A full minute with no response. Then:

*So you tell me you love me, and then four days later you can't even see me because of how it might look.*

I could hear his voice through the text. The careful control masking devastation.

*That's not fair.*

*Nothing about this is fair, Berna. I'm facing a potential recall that could destroy my company. My sister is asking questions about her health that I can't answer. And the person I,*

He stopped typing. Started again.

*Never mind. Do what you have to do. I'll be here dealing with the actual crisis.*

*Sam, please.*

*I have to go. My lawyers are calling.*

He meant the new lawyers. The ones Gloria was assigning. The ones who weren't me.

I set my phone down on the kitchen counter and stood there in the cold air from the open windows, feeling the distance between us crystallize into something solid and impassable.

Four days ago, we'd stood on his roof in the rain and promised each other something. I didn't know what exactly,we'd been too careful to use words like *forever* or *always*,but we'd promised something. A willingness to try. A belief that this could work.

Now we couldn't even be in the same room.

I thought about calling him. Explaining that this wasn't what I wanted, that I was trying to protect us both, that staying away was the only way to prevent things from getting worse. But even that felt compromised now. Every conversation we had could be analyzed for signs of coordination. Every text could be read as evidence of divided loyalties.

The professional ethics I'd built my career on were doing exactly what they were designed to do: creating distance. Enforcing boundaries. Preventing conflicts of interest from corrupting professional judgment.

I just hadn't expected it to hurt this much.

---

At 4:30, my phone rang. Not Sam,Marco.

"You sound terrible," he said, by way of greeting.

"I'm fine."

"Liar. What happened?"

I couldn't tell him everything. Attorney-client privilege, ongoing review, all the professional constraints that still applied even though I'd been yanked off the engagement. But I could tell him the shape of it.

"I disclosed my relationship with Sam to Gloria. I'm being investigated for conflict of interest. I can't see him or talk to him until the review is complete."

Silence. Then: "Carajo."

"Yeah."

"How long?"

"A week, maybe two."

"And Sam? How did he take it?"

I thought about his last text. *Do what you have to do.* The careful distance in those words.

"Not well," I admitted.

Marco was quiet for a moment. "You did the right thing, you know. Disclosing."

"I know."

"That doesn't make it hurt less."

"No." I pressed my hand against my chest, where that sharp thing was still lodged between my ribs. "It really doesn't."

"Come to Sazón tonight. Don't argue,just come. I'll feed you and you can sit in the kitchen and not talk about any of it. Sometimes that helps."

I wanted to say no. I wanted to stay in my cold apartment and wallow in the wreckage of everything I'd built over the past two months. But Marco was right. Sometimes the only thing you could do was let someone take care of you, even when you didn't deserve it.

"Okay," I said.

"Seven o'clock. Don't be late."

He hung up before I could change my mind.

I stood at my window and watched the light fade over Portland, thinking about all the ways things could have been different. If I'd disclosed earlier. If I'd kept things professional. If I'd never let myself fall in love with a client's founder in the first place.

But I had. And now we were here,Sam facing the possible destruction of everything he'd built, me facing the possible destruction of everything I'd built, and neither of us able to reach for the other.

The last time we'd touched was this morning, before I read the report. He'd reached for the coffee pot and I'd been standing right there, close enough to feel the warmth of his body. Close enough to touch, if I'd wanted to.

I hadn't. I'd already known, even then, what was coming.

Now the wall was back. Invisible, absolute.

And I had no idea if we'd ever find a way through it again.

$akm001ch13$,
  3678
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  14,
  'Chapter 14',
  $akm001ch14$
# Chapter 14

## Day 1

Marcus Okafor had four whiteboards.

This was not unusual for a litigator, but Marcus had pushed his desk into the corner to make room for the fourth, which he had apparently purchased that morning, based on the sticker still adhering to the lower-right corner. The sticker said: FULL-SURFACE MAGNETIC. I filed that detail next to the other things I was not going to think about.

He was thorough. That was the main thing I had to hold onto. Marcus was thorough, had appeared in the firm's quarterly reports twice under "notable outcomes," and had a coffee setup on his credenza involving three separate vessels , a burr grinder, a gooseneck kettle, a ceramic dripper , which meant he was the kind of person who cared about process at the granular level. Sam's case needed process. Sam's case needed someone who could hold the full architecture of the CeraTest liability question in his head without the part where any of it was personal. Marcus was perfectly, usefully impersonal, which was why Gloria had chosen him and why I was going to hand him three months of my work and be grateful.

I had the folders tabbed. I had a summary document. I had a decision log organized by date.

"The cadmium trace was confirmed through a third-party materials test on March 8th," I said. "The chain of custody documentation is in the blue folder. Tab 6."

Marcus did not look at tab 6. He was looking at me with an expression I recognized as professional sympathy, which is sympathy pre-cleared by legal counsel and containing no actionable heat.

"Berna."

"The supplier communication is in tab 9. There's an internal email from CeraTest , their QA director to their sourcing team, dated fourteen months ago , that's going to be the center of their exposure. Marcus will want to build the timeline around that date."

"You just referred to me in the third person."

"I'm aware I did that." I moved on. "The recall was voluntary. That's important for optics. Holloway initiated it before the agency contact, which positions them well for any good-faith mitigation argument. I've flagged the regulatory sequence in the orange tab. The order of contact matters."

Marcus wrote something on the whiteboard nearest to him. The whiteboards were color-coded. He had a system in progress, arrows and bracketed notations, and it was a system I recognized as competent , built for someone coming in on Day 1 with the advantage of not having been inside the case while it was still something other than a case. I was not going to look at what he had written. I was professionally focused and emotionally stable, and then Marcus turned around to grab a marker from the tray on the second whiteboard and I could see his organizational taxonomy in full.

The sections were labeled in different colors: SUPPLIER LIABILITY (green), RECALL MECHANICS (blue), REGULATORY EXPOSURE (orange), THIRD-PARTY TESTING (purple), and , in a smaller, secondary column, in red, in Marcus's precise block print , PERSONAL ENTANGLEMENT DISCLOSURE DELAY.

He had made it a category.

He had a whole section. There were sub-bullets. I could not read the sub-bullets from where I was standing and I was not going to cross the room to read them, but they existed, and somewhere in Marcus Okafor's rigorous categorical mind, the eleven days between when I understood what was happening and when I told Gloria had been processed into a filing system with its own heading and its own indentation hierarchy. This was, objectively, the correct approach to case management. He needed to know the shape of my conflict because the shape of my conflict was now a structural element of the case. It was also the bureaucratization of something I was not currently naming, and there was something clarifying and terrible about seeing it in red block letters on a four-by-six whiteboard next to the word MECHANICS.

I kept briefing him. I was excellent at it. I knew this case better than anyone else in the building , the CeraTest email, the chain of custody for the cadmium trace, the recall initiation timeline, the three versions of the supplier contract and the paragraph in version two that contradicted version three , and I handed all of it to Marcus with both hands and a complete index and a summary document that anticipated his first eight questions, because if I was going to lose this case from my caseload I was going to lose it in a way that left no opening for anyone to say I had done it badly.

We were at two hours and forty minutes when Marcus set down his marker.

"There's one more thing," he said.

He said it in a tone that was different from the rest of the briefing. I noted the tone.

"CeraTest's internal QA review." He opened a folder I had not given him. "Eighteen months ago. Not the one you found. An earlier one."

I looked at the folder.

"Their own team flagged the methodology concerns. The same concerns. They ran it up to senior management. The decision was made not to act." He turned a page toward me. "Sam Reyes received documentation of this yesterday. He's pursuing legal action."

The date was correct. Eighteen months ago meant eight months before the recall, before the third-party test, before any of it. The CeraTest QA director had known. Someone above the QA director had known. A decision had been made in a meeting that probably had a nice view and good coffee, and after that meeting a product with a contamination problem had continued to move through distribution while Sam Reyes sold it in good faith to restaurants and institutions and people who had not been told there was a question worth asking.

It was never Sam's fault. I had understood this mathematically for weeks. I understood it differently now.

I set the page down.

"Does Marcus need anything else from me before I go?" I said, and then caught it. "Do you need anything else."

"I don't think so."

I picked up my folder. I did not take the page. I said something appropriate and walked out of his office at 11:47 AM and stopped in the hallway and looked at the wall for approximately four seconds, during which I did not think about a phone call I was not going to make, a voice on the other end of it I was not going to hear, three words , *it wasn't you* , that I had no professional mechanism for delivering and no personal standing to deliver.

Then I walked to the kitchen and made a cup of coffee and went back to my own desk and opened the Strelikov matter, which was waiting for me with the patience of something that had never involved anyone I,

The Strelikov matter was waiting for me.

I opened it.

---

## Days 2–3

The firm is quieter than I remembered. I don't know when I stopped noticing that, but I noticed it now, which suggested I had, at some point, stopped noticing. I had walked through this building for eight years and felt its particular quiet as neutral, as professional, as simply the sound of people working. Now it was the sound of people working on things that had nothing to do with me, which was the same silence and an entirely different experience of it.

My mug was wrong. I use the same white mug every morning , H&P's name on it, a hairline crack along the base that has been there for two years and never gotten worse, a specific heft I had dropped it once and it hadn't broken and filed under: reliable. And then I picked it up on Day 2 and it was the wrong weight. Not lighter than I remembered, exactly. More like , less full of itself. I kept picking it up expecting it to weigh more and it kept not weighing more, and by 9 AM I had noticed this three times and categorized it under things I was not going to write down anywhere.

My keyboard has a sticky P key. It has had a sticky P key for eight months. I have submitted a maintenance request twice. The P works if you press it firmly and with intent, which is fine for most words, but I have been signing emails B. Alvarez because I cannot locate the will to type my full name twice a day. On Day 2 I pressed the P without thinking and it worked, and I sat there looking at my own correctly-rendered signature and felt the particular flatness of a small thing going right in the wrong week.

I worked until 8 PM. This was not unusual. I did not go home the usual way.

On Day 3, Gloria came to my desk, which was unusual. Gloria generally does not come to desks. She has an office with a door and a standing meeting on Thursday afternoons and an assistant who emails on her behalf. Gloria appearing at a desk means something has been decided and warrants delivery without a calendar invite.

She sat in the client chair. She did not bring coffee, which was a data point.

"I want to tell you something before you hear a version of it in a partners' meeting," she said.

"Okay."

"You were eighteen months from being considered for equity track." She paused, just briefly, to let that land rather than soften it. "That timeline resets today."

I did the math. I had known the math was going to be bad. Eighteen months plus reset meant roughly three years, depending on how generously they interpreted "resets," which was not a word with legal precision, and I was not going to ask for clarification. Three years from now I would be thirty-nine. I had not previously associated that number with a milestone. I was now.

"I understand," I said.

"I'm not here to make you feel worse about it. I'm here because you should know the number."

"I appreciate that."

She looked at me for a moment in a way that was not unkind. Eight years was enough for a reasonably accurate map of what my face does when I am managing something. She did not address what my face was doing. "The work you did on the preliminary analysis was excellent, Berna. That is documented. It will count."

"But not toward equity track."

"Not toward equity track." She stood. "You've been here eight years. You'll be fine. I mean that."

After she left I looked at the Strelikov brief for approximately ninety seconds without reading it. Then I read it. The reading was not difficult. I am good at reading. I can read through almost anything, which has always been, depending on the day, either my best professional asset or a fairly damning statement about my interior life. The Strelikov brief was forty-two pages. I read all forty-two. I had notes by the time the office cleared out, and the notes were good, and I had pressed the P key with appropriate force, and none of this was the thing I was doing instead of the other thing because I had decided there was no other thing.

---

## Days 4–6

I stopped going to Marco's.

This lasted four days, which felt correct , the kind of number that sounds like discipline , and then turned out to be insufficient. I had been going to Marco's on Tuesday and Thursday evenings since I made senior associate, because it was three blocks from the office and Marco had once told me that lawyers who eat at their desks die angry, and I had laughed and kept eating at my desk for another eight months before eventually showing up at 7 PM on a Tuesday with the Alderton file under my arm. That had become the shape of my week. On Day 4, with a brief due and my apartment doing what apartments do when you have been in them too much, I went in.

Marco placed the ribollita in front of me without being asked. Then he stood there for one beat too long.

"He came in," he said.

I did not ask when. This was a choice I made in the two-second window before the next thing he said.

"Two nights ago," Marco said. "He ate at the counter. He had the crespelle. He didn't stay for dessert."

Sam does not skip dessert. Sam once made a serious argument to me that tiramisu was a category of evidence in any conversation about why Italian immigrants changed the character of the Pacific Northwest, and I had responded that this was not how evidence worked, and he had said the tiramisu was exhibit A, and I had eaten the tiramisu, and that had been a Tuesday, which was not relevant, and was extremely relevant.

"How did he seem?" I asked, which was a mistake.

Marco sat down across from me, which meant the answer required seating.

He was quiet for a moment, arranging it. Marco is not a person who gives you the sentimental version. He gives you the accurate version, and he waits until he has the right words. "You know how you can tell when someone's thinking hard, but it's not , it's not the good kind. Not solving something. Just stuck somewhere and working at it." He tapped his temple. "Like someone had scooped out the part that makes him Sam. Just the bones of him sitting there. He ate the crespelle. He tipped well. He left."

I looked at my ribollita.

"He asked about you," Marco said. "Not in a way that expected an answer. He just said , is she okay? I said I thought so. He said good." Marco spread his hands. "That was it."

I ate the ribollita. It was very good, the way it is always very good, thick and slow and warm in a way that operates below thought, and I thought about the crespelle and about tipping well and about the bones of someone sitting where the whole person used to be, and I did not cry into the ribollita, which I am logging here as a moderate professional success.

Marco refilled my water and went back to the kitchen. He came back twenty minutes later, by which point I had finished the ribollita and started on the brief I had brought with me and was doing fine.

"There's something else," he said.

He sat down again. I set down my pen.

"Elena was here. Two days ago , the day before Sam came. She sat at the window table. Had the lunch. She asked about you."

I waited.

"I told her you were dealing with work things. That you weren't eating, or , I don't know, I said you seemed okay. I said what I knew." He looked at the table. "She asked me what she should tell Sam. I didn't know what to say to that. I didn't say anything."

Elena had been Sam's sister first for twenty-eight years before I ever entered the equation. I did not have a clear picture of what these two weeks had looked like inside that family, and I had been not-constructing that picture with some effort. Elena reaching out , not to me, but toward me, close enough to send a signal , was not something I had expected. Not warmly, exactly. But not with the kind of silence that means the door is closed.

"She didn't leave a number," Marco said. "She didn't ask me to pass anything along. She just asked how you were."

I nodded. I looked at the brief. I picked up my pen.

"Okay," I said.

Marco went back to work. I sat with the brief and the empty bowl and the information I had just been given, and I parsed it into its component parts and did not do anything with any of them, because there was nothing to do, and then I tipped well and went home.

By Day 6 I knew from a paralegal who works the CeraTest adjacent matters that Sam had retained outside counsel to pursue the supplier action. This was the correct move. If Marcus was doing his job, Sam's attorney had what they needed. Sam retaining counsel meant Sam was functional. Sam functional was what I needed him to be.

I went back to Marco's on Day 6. Marco did not say anything. I left a large tip.

---

## Day 9

6:15 PM. The shadows on Wasco Street go long in February, and I was half a block south of the building, collar up, bag on one shoulder, when my body stopped walking before my brain had finished a thought.

Across the street. Maybe sixty feet ahead.

Tall. The specific posture , weight carried slightly forward, like he's perpetually about to say something, like stillness is a mode he hasn't fully learned. A cable pouch on his belt, dark canvas, clipped to the left side.

I stood on the sidewalk outside a dry cleaner and I did not move.

The light was wrong for February, cut at an angle that threw half the opposite sidewalk into shadow, and the figure was in the shadow, and I was making an inventory without meaning to: height, yes. The set of the shoulders, yes. The cable pouch. The cable pouch was the specific detail that had stopped me , I had seen that cable pouch on a kitchen counter and on a bedside table and clipped to a belt loop, and I had one in my bag right now, which was not relevant, which was extremely relevant.

He was walking. He was not looking across the street.

I did not call out. I did not step off the curb. I watched the shape of him cross the mouth of the side street and round the corner and disappear, and I did not close the distance between us quickly enough to see his face, and I did not know whether this was because sixty feet was too far and February light is unreliable, or because I had made a decision in the same two-second window I had been operating in all week , the window in which I could choose not to find out.

A couple came down the sidewalk and walked around me. The woman gave me a brief look. I was standing in the middle of the sidewalk looking at the corner of a building.

I stood there for longer than I should have. The corner stayed a corner. The cable pouch in my bag weighed what it weighed.

I walked home the short way.

I walked home telling myself: the posture was similar, that's all. February makes everyone into their own silhouette. I had no basis for a positive identification at sixty feet in bad light. The face , I hadn't seen the face. That was the relevant variable. I hadn't seen the face because there hadn't been time, not because I had specifically not crossed the street.

I carried the cable pouch in my bag still. I had been carrying it for ten days. This was because I had not gotten around to returning it. This was what I was calling it.

---

## Day 10

I arrived at the office at 7:08 AM.

This was because I had left my apartment at 6:41, which should have put me at my desk by 7:00, and then at the Burnside intersection I had turned right instead of left without fully deciding to, and taken the long route along the river side, and then three blocks later turned again back to my normal route because there was no logical reason the long route was safer , Sam did not live on the river side, Sam lived eleven blocks northeast, the river had nothing to do with anything , and by the time I finished sorting this out I had covered eleven blocks I had not meant to cover and it was 7:08 AM.

I did not log this in my time sheet. I considered it briefly , there's a category for "commute irregularities" that nobody has ever used, and I am not certain it was created for situations of this kind, but it does exist , and then decided that documentation would make it worse. Some things are cleaner as private failures.

I made coffee. I opened the Strelikov brief. I pressed the P with appropriate force.

---

## Day 12

At 4:47 PM, an email from Gloria's assistant appeared in my inbox.

> *Ms. Alvarez , Ms. Yuen would like to schedule 30 minutes tomorrow at 10 AM. Please confirm availability.*

Gloria's assistant does not explain the subject of meetings. This is policy, not oversight. You confirm the availability and you find out tomorrow.

I confirmed availability.

I set my hands in my lap and looked at the parking garage across the street , that flat grey wall I have looked at for eight years, poured concrete, a single horizontal seam at two-thirds height, a strip of yellow paint along the bottom level that says CLEARANCE 7 FT. It has never been anything other than a parking garage. It does not remind me of anything. And yet here I was on Day 12 looking at it with the attention I usually reserve for documents, and the seam was still at two-thirds, and the yellow paint still said what it said, and none of this resolved anything.

I had an Oregon's Best Cinnamon Roll in my desk drawer. I had purchased it three days ago from the cart in the lobby in a moment of what I can only describe as ambient optimism , the idea that I would want it later, that later would be a time when a cinnamon roll was the right answer. I had not opened it. It was still there in its wax paper sleeve, slightly compressed from being in a drawer. Whether this was stubborn optimism or a small punishment I had not yet determined. I was leaving the determination open.

The sticky P key was under my fingers.

Ten o'clock tomorrow.

I kept working.

$akm001ch14$,
  3723
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  15,
  'Chapter 15: The Texture of After',
  $akm001ch15$
# Chapter 15: The Texture of After

Gloria's office at 9 AM felt like a sentencing hearing.

Not that I'd ever been sentenced to anything. Unless you counted that parking ticket in 2019, which I did not, because my meter had clearly malfunctioned and I'd been proven right by the Portland Bureau of Transportation's own audit. A victory I still thought about more often than was psychologically healthy.

"Sit," Gloria said, and I sat.

The morning light came through her windows at that angle that made everything feel consequential. I'd been in this office a hundred times, but never across from her like this,not as a colleague, but as a subject of review.

"Marcus completed his assessment yesterday," Gloria said. "His report is thorough. It's also, fortunately for you, exculpatory."

I waited. Exculpatory was a good word. Exculpatory was my favorite word.

"Your work product on the Mobility Workshop engagement was technically sound. No errors, no omissions, no evidence that your personal involvement affected your professional judgment." She paused. "The conflict of interest remains a serious violation of firm policy. But you didn't compromise the work itself."

"I understand."

"Do you?" Gloria leaned back in her chair, studying me with those slate-gray eyes that had terrified first-year associates since before I was born. "Because what I'm seeing is a woman who knows the rules, chose to break them, and got lucky that the consequences weren't worse."

I didn't argue. There was nothing to argue with.

"I'm not firing you," she continued. "You're too good an attorney, and frankly, the firm can't afford to lose your billable hours right now. But you're on supervised status for six months. Any client interactions with personal dimensions,any at all,get disclosed immediately. And you're permanently off any matter involving Mobility Workshop, CeraTest, or anyone connected to them."

"I understand."

Gloria's expression shifted. Something almost human moved behind the professional mask. "Berna. You did the right thing."

I blinked. "I'm sorry?"

"Disclosing when you did. Coming to me before this became a larger problem." She folded her hands on her desk. "It took courage. And it protected the firm from exposure that could have been catastrophic."

"It was basic ethics. It's what I should have done months earlier."

"Yes, it was. And yes, you should have." Gloria's mouth curved,not quite a smile, but close. "But you also could have waited until Marcus found it himself. You could have tried to hide it. You could have done what most people do when they realize they've made a mistake,cover it up and pray. You didn't."

I didn't know what to say. Gloria complimenting me felt like being praised by a glacier. Nice, but fundamentally disorienting.

"And the other thing," she added. "Walking away from him. Maintaining professional distance during the review." Her eyes met mine. "I know that was harder than the disclosure. You did the right thing. Both times."

Something in my chest cracked open. Not in a dramatic way,more like a pressure valve releasing. I'd spent two weeks carrying the certainty that I'd destroyed everything, that Gloria would never trust me again, that my career was a smoking crater of bad decisions.

You did the right thing. Both times.

I might have cried if I were someone who cried in front of bosses. Instead, I nodded once, professionally, and said, "Thank you."

"Now." Gloria's tone shifted back to business. "The supervised status starts today. Harrison Webb is here for a meeting with the new Mobility Workshop team in an hour,I need you visible but uninvolved. Your presence in the building demonstrates continuity. Your absence from the meeting demonstrates appropriate boundaries."

"Visible but uninvolved," I repeated. "So... I just stand in the hallway looking purposeful?"

"You sit in the small conference room adjacent to Conference A and review documents. The glass walls mean Harrison can see you working. The closed door means you're not in his meeting."

I processed this. "That's remarkably calculated."

"That's firm management." Gloria stood, signaling the meeting's end. "Go be visible, Berna. And try not to make eye contact with anyone who might complicate things."

---

The small conference room adjacent to Conference A was essentially a fishbowl.

Glass walls on three sides, a view into the main conference room through the interior partition. I could see everything,the long mahogany table, the screens for presentations, the water pitchers with their precisely arranged lemon slices. And in forty-five minutes, I would see Harrison Webb conducting a meeting about the company I was permanently banned from touching.

I spread my documents across the table. Real work,a trademark dispute that had nothing to do with ceramics or medical devices or anyone named Reyes. I opened my laptop. I arranged my face into an expression of professional concentration.

I was being visible. Very purposefully visible.

Twenty minutes passed. I actually managed to focus on the trademark dispute, which involved a bakery in Eugene and a bakery in Salem both claiming rights to the phrase "Oregon's Best Cinnamon Roll." Neither bakery's cinnamon rolls were Oregon's best. I'd tried both. Marco's were better, and he didn't even make cinnamon rolls professionally.

The door to Conference A opened.

I heard Harrison's voice first,the measured cadences of someone who'd done business in three languages and spoke all of them like weapons. ",need to see the reformulation timeline before we can discuss further investment."

"We'll have that by Friday," said a voice I didn't recognize. The new attorney, probably. Someone corporate, someone safe, someone who'd never made the spectacular error of falling in love with a client's founder.

Then: "Friday works. Elena's coordinating the testing schedule now."

My pen stopped moving.

Sam's voice. In the building. Twenty feet away, through glass walls and a decade of professional training that was currently doing absolutely nothing to prevent my heart from launching itself against my ribcage like a suicidal bird.

Don't look up, I told myself. Don't look up. Don't look,

I looked up.

He was in the hallway. Walking between Harrison and the new attorney, his attention on something Harrison was saying. He looked,god, he looked tired. The lines around his eyes deeper than they'd been two weeks ago. His shoulders carrying weight that hadn't been there before.

But he was moving. Working. Fighting for the company he'd built.

Three more steps and he'd be past the glass. Three more steps and this would be over.

He glanced toward my conference room.

Our eyes met.

Time did that thing it does in movies, except in real life it's worse because you can't cut to the next scene. You just have to live through it,the recognition, the flash of something raw and unguarded crossing his face, the way his step faltered for half a second before professional momentum carried him forward.

I didn't wave. I didn't smile. I held his gaze for exactly as long as you hold a stranger's gaze when you accidentally make eye contact,one second, maybe two,and then I looked back down at my trademark documents.

Oregon's Best Cinnamon Roll. Very important. Very compelling. Definitely the thing I was thinking about.

His footsteps faded down the hallway. The voices moved toward the elevator. Conference A filled with the rustle of people settling in for a meeting I wasn't allowed to attend.

I sat there with my hands flat on the table, feeling the precise weight of what I'd just survived.

We'd been in the same room. We'd seen each other. We hadn't spoken or touched or done anything that could be construed as coordination.

It was exactly what the rules required.

It was also the most painful two seconds of my entire professional career.

---

I worked through the trademark dispute until noon, mostly because I couldn't figure out how to leave the conference room without risking another hallway encounter. When my phone buzzed with a text from Marco, I grabbed it like a lifeline.

*Lunch at Sazon. Don't argue.*

*I'm busy.*

*You're hiding in a glass box staring at documents you finished an hour ago. Elena told me.*

My fingers tightened on the phone. *Elena is at the office?*

*Elena was at the office. Now she's here. Asking about you. Come have lunch.*

I looked at my documents. Looked at the glass walls. Looked at the empty conference room next door, where Harrison's meeting had concluded twenty minutes ago.

*Fine. Twenty minutes.*

---

Sazon at noon was a different creature than Sazon at night,faster, louder, full of the rushed energy of people who had somewhere to be. Marco had claimed his usual corner booth, but he wasn't alone.

Elena Reyes sat across from him, her wheelchair parked at the table's end, her expression unreadable as I approached.

"You came," she said.

"Marco threatened me."

"I asked him to." She gestured to the seat beside her. "Sit. We need to talk."

I slid into the booth, acutely aware that this was the first time I'd been face-to-face with Elena since everything fell apart. The last time I'd seen her, I'd been asking about Sam's coffee ritual, laughing at his terrible plumbing skills, letting myself believe this thing between us might actually work.

"I'm not supposed to," I started.

"Coordinate. I know. This isn't coordination. This is me talking to you about my brother without his knowledge or permission." Elena's smile was small and precise. "Technically a violation of family loyalty. Professionally irrelevant."

Marco set plates in front of us,tostones, the small empanadas I liked, rice that smelled like heaven. "I'm going back to the kitchen. You two need privacy."

"We need supervision," I said. "In case of,"

"In case of what? Elena's going to attack you with a cinnamon roll?" Marco snorted. "Eat. Talk. Stop acting like you're on trial."

He disappeared into the kitchen. Elena picked up an empanada, then put it back down. She looked at me for a moment,not unkindly, but measuring something.

"I watched him not eat for four days," she said.

I didn't respond. There wasn't a response to that.

"I sat outside the workshop door at midnight and knocked until he came out. He wouldn't tell me what he was working on." Her voice was flat, not angry, which somehow made it worse. "He just said it was fixable." A beat. "I'm not saying that to make you feel guilty. I'm saying it so you know what the last two weeks actually looked like."

I looked at my tostones.

"He's my brother," Elena said. "Before he's anything else. And the version of him I've been watching for two weeks,that's not a version I want to repeat."

I let that sit. She'd earned the right to say it.

"Okay," I said. "I understand."

Something in her face shifted slightly,not softening exactly, more like she'd gotten confirmation of something she'd needed to check. She picked up the empanada again.

"He's doing better," she said. "Now. The recall went through clean. No health incidents, no lawsuits, no customers screaming on Twitter. CeraTest's legal team is already making noise about settlement. And the reformulation," She paused, something complicated crossing her face. "He fixed the glaze."

I set down the toston I'd been pretending to eat. "He what?"

"Fixed it. Three days ago. Found a supplier in Seattle, modified the compound, ran initial tests." Elena's voice was careful, neutral. "He's been in the workshop every night until midnight. Solving the problem instead of drowning in it."

I tried to imagine it,Sam bent over his worktable, surrounded by ceramic samples and chemical analyses, fighting his way through the technical maze that had nearly destroyed everything. Fixing what was broken instead of breaking himself against it.

"That's good," I said, because it was all I could say.

"It is." Elena set down her empanada and looked at the table for a moment,not sad, but carrying something. "There's also the business side. The Series A meeting got pushed to April. The recall delay cost three months on his funding timeline,investors needed to understand why in writing before they'd reschedule." She looked at me directly. "He wrote the explanation himself. He laid out what happened with CeraTest's negligence, what the reformulation would cost, what the new timeline looked like. He didn't blame anyone. Not the firm, not the process, not you."

Three months. I ran the number automatically: a Q1 close pushed to Q2, which meant different debt covenants, different runway assumptions, a different version of every conversation he'd have with his board for the rest of the year. That wasn't just a calendar adjustment. That was a material change in how the company would be built.

"He did it without blaming anyone," I said.

"Without blaming anyone." Elena nodded once.

"Here's the other thing," she said. "The thing I actually came to tell you."

I waited.

"He doesn't blame you." Her eyes met mine, steady and direct. "I know you think he does. I know those last messages were cold and awful and he was shutting down because that's what he does when he's scared. But he doesn't blame you for the disclosure, or the distance, or any of it."

"Elena,"

"He blames himself. For putting you in an impossible position. For not being better about the conflict of interest from the start. For," She stopped, her hands flat on the table. "For loving you in a way that made you choose between him and your career."

The word landed between us. Loving. Present tense. Still happening, apparently, despite everything.

"I made my choice," I said quietly. "I chose my career."

"Did you?" Elena tilted her head. "Because from where I'm sitting, you chose both. You disclosed the relationship, which protected you professionally. And you walked away, which protected him from any appearance that you were coordinating your stories." Her smile turned sharp. "That's not choosing your career over him, Berna. That's trying to save both. Whether it works," She shrugged. "That's another question."

I didn't know what to say. I'd spent two weeks assuming I'd destroyed whatever we'd been building,that choosing professional ethics meant choosing against him. But Elena was offering a different reading. A more generous one.

Maybe a more accurate one.

"Why are you telling me this?" I asked.

"Because my brother won't." Elena picked up another empanada. "Because he's too busy apologizing to everyone he's ever met and too stubborn to ask for help. And because," She paused, her voice softening. "Because you made me laugh. That day at my apartment, with the plumbing. When you asked Sam if he was actually planning to fix the pipes or just have a philosophical conversation with them. That was the first time in months I'd seen someone tease him and have him enjoy it."

I remembered. The look on Sam's face,half offended, half delighted that someone had finally called out his tendency to overthink mechanical problems.

"He needs that," Elena continued. "Someone who sees through his nonsense. Someone who isn't impressed by the workshop or the company or the whole Sam Reyes mythology." She met my eyes. "Someone who argues with him about ceramics and steals his olives and makes him better instead of just telling him he's brilliant."

"I can't see him," I said. "Not until the supervised period is over. And even then,"

"Even then, it's complicated. I know." Elena finished her empanada, brushed the crumbs from her fingers. "But the supervised period has an end date, right? June?"

"May. Six months from the disclosure."

"May." She nodded slowly. "So in May, you'll be allowed to contact him again. Theoretically."

"Theoretically."

"And by May, the CeraTest situation will be settled. The reformulation will be complete. The Series A will have closed." Elena smiled,a real smile this time, not the measured one she'd come in with. "What I'm saying, Berna, is that you have three months to figure out what you want. And so does he."

I stared at her. "Are you matchmaking me? With your own brother?"

"I'm providing relevant information to an interested party." Her smile widened. "Consider it legal strategy."

Marco reappeared with coffee,the good kind, not the terrible stuff Sam made. "You two done plotting?"

"We weren't plotting," Elena said. "We were strategizing."

"Same thing." Marco set a cup in front of me. "Drink. You look like you haven't slept in weeks."

"I've been busy."

"You've been miserable. There's a difference." He dropped into the booth beside me, ignoring the line of customers at the counter. "Elena's right, you know. He's not angry. He's scared. There's a difference there too."

"How do you know what he's feeling?"

"Because I have eyes. Because he came to pick up Elena yesterday and spent ten minutes asking about you without actually asking about you." Marco's voice was fond but exasperated. "He wanted to know if you'd been eating. If you were sleeping. If you seemed okay. He asked about the trademark dispute,which, by the way, how did he even know about the trademark dispute?"

"I don't know," I said. But I did know. I could feel myself reaching toward the knowledge like touching a fresh bruise.

He'd been paying attention. Even from a distance. Even through intermediaries.

The same way I'd been paying attention to him.

"Look," Marco said. "I've watched you mope around my kitchen for two weeks, pretending you're fine. I've watched him walk past this building three times that I know of, probably more that I don't. Neither of you is fooling anyone."

"We're respecting the boundaries,"

"You're respecting the boundaries, yes. Very professionally. Very correctly." Marco leaned in. "But the boundaries have an expiration date. And when they expire, I expect you both to stop being idiots."

Elena snorted. "That's the least subtle thing I've ever heard."

"Subtlety is overrated." Marco stood, heading back toward the kitchen. "Eat your tostones, Berna. You've got three months to figure out your life."

---

I went back to the office after lunch.

The glass conference room was empty now, someone else's meeting in progress in Conference A. I gathered my documents, packed my laptop, headed for the elevator.

In the lobby, I paused.

There was a cable pouch in my bag,the one I used to bring to Forge & Flow, the one with the three different charging cables because Sam's devices used formats that should have been illegal. I hadn't needed it since moving back to Hanover & Pryce. The office had standard chargers. Normal equipment. Nothing that required three different USB variants.

I touched the pouch through the fabric of my bag. A tactile ghost.

Upstairs, on my desk, there was a mug I'd borrowed from the break room. It was the wrong weight. Too light, too glossy, too impersonal. Nothing like the chipped ceramic that lived in Sam's kitchen cabinet,the one I'd left behind when I left, the one that had never been mine anyway.

These were the things he'd changed without meaning to.

The cable pouch I carried out of habit. The mug that felt wrong because I'd learned what right felt like. The way I caught myself looking at ceramic displays in store windows, evaluating glaze quality, thinking about degradation rates and temperature thresholds.

He'd gotten into my brain. Into my professional reasoning, my aesthetic preferences, my involuntary thoughts.

I hated it. I also, if I was being honest, didn't hate it at all.

I walked to the elevator. Pressed the button. Waited.

And when the doors opened, I stepped inside and let myself think,for just a moment,about May. About what might happen when the boundaries expired.

About what I wanted to find on the other side.

---

That night, I drew the Forge & Flow floor plan from memory.

I was sitting on my couch, pretending to watch television, when I found myself sketching on the back of an envelope. The coffee station in the corner. The glass-walled offices along the south side. The open workspace where the graphic designers clustered. His partition wall, now permanently vacant.

I drew it all. Every detail. The chalkboard with its terrible quotes, the acoustic panels that didn't quite work, the angle of the afternoon light through the high windows.

I drew myself into it too. The small office I'd claimed as my own. The desk where I'd spent three months watching him through glass. The invisible thread that had connected us, conference call to conference call, glance to glance, silence to conversation to something more.

When I finished, I looked at what I'd made.

It was a map of a place I couldn't go back to. A floor plan of a building where I no longer worked. But it was also evidence of something else,proof that I'd been changed by occupying that space. By occupying it with him.

I folded the envelope carefully and put it in my desk drawer.

$akm001ch15$,
  3454
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  16,
  'Chapter 16',
  $akm001ch16$
# Chapter 16

The email arrives at 7:43 AM on a Tuesday, which is how I know the universe has a sense of humor.

*Re: Forge & Flow Accessibility Compliance - Final Walkthrough*

Harrison's name in the CC line. Gloria's in the To field. And buried in the body text like a landmine in a paragraph: *...representatives from Mobility Workshop will be present to verify installation specifications...*

I read it three times. Then I check the calendar.

April 4th.

Twenty-six days until May.

I've been counting in my head for weeks now,the number changing each morning when I wake up, a reverse countdown that feels less like anticipation and more like holding my breath underwater. Twenty-six days doesn't sound like much. It sounds like nothing. It sounds like forever.

Gloria appears in my doorway. "You saw it."

"I saw it."

"Harrison specifically requested you. Something about your 'excellent rapport with the Forge & Flow team.'" She delivers this with a straight face that probably took years of partnership meetings to perfect. "I told him you had a conflict."

"Do I?"

"You will if you want one."

I should want one. I should invent a dental emergency, a family obligation, a sudden-onset case of being anywhere else on the planet. The professional boundaries are clear. The personal ones are clearer.

But the walkthrough is for accessibility compliance verification.

Which means documentation.

Which means I'll see exactly how Sam Reyes handled the glaze issue,whether he actually read those safety reports or just signed off on someone else's summary. Whether Elena was telling the truth about him fixing it, or whether she was just being a sister, seeing what she wanted to see.

I've been building a case in my head for two months. A case for why he changed too late, or not enough, or only under pressure. A case for why the separation is necessary, why May is the right timeline, why trusting him again would be professionally reckless and personally catastrophic.

The problem with building cases is that evidence can go either way.

"I'll go," I tell Gloria.

She doesn't argue. Just nods once, like she expected this, and leaves me alone with my inbox and my countdown and the drawer in my desk that I haven't opened since February.

---

The Forge & Flow space looks different in April.

Not the architecture,that's the same. The ramps I designed, the wide doorways, the bathroom stall placement that took three rounds of revision because the contractor kept "improving" my specifications. But someone's added plants. A fig tree in the corner, tall and reaching toward the skylights. Succulents on the windowsills. The concrete floors that looked industrial in winter now look intentional, warmed by natural light pouring through the glass.

The glass that Sam fixed.

I see the documentation before I see him.

It's spread across a folding table near the entrance,the verification binders that Harrison's team assembled for final sign-off. I shouldn't stop. I should wait for the formal walkthrough, maintain professional distance, keep my hands at my sides and my pulse at a reasonable rate.

Instead, I pick up the first binder.

*Material Safety Verification: Tempered Glass Panels, Zones A-F*

The tabs are color-coded. The sections are numbered. And in the margins, in handwriting I'd know anywhere,small, precise, the letters slanting slightly left like they're trying to keep up with his thoughts,

Notes.

Not signatures. Not initials. Actual notes.

*Verify thermal expansion coefficient against ASTM C1048. Called manufacturer directly,confirmed standard compliance.*

*Cross-reference with ADA guidelines section 4.13.10. Checked.*

*Elena said to trust the supplier's word. I called the supplier anyway. Then I called their supplier.*

Page after page. Every glass specification, every safety standard, every technical document that I'd flagged in my original compliance report. He didn't just read them. He tracked them back to their sources. He built his own verification chain from the ground up, as if my concerns had been a blueprint for his suspicion.

*Original supplier couldn't provide third-party testing documentation. Switched to Clearview Industrial,costs more but full paper trail. Worth it.*

The second binder is worse. Or better. The installation timeline, annotated with delay explanations and quality checkpoints and a note in the margin that reads, simply: *B. was right. Blind trust is efficient but stupid.*

B.

Not "the attorney." Not "opposing counsel." Not "my wife" or "my ex-wife" or whatever we technically are in legal limbo.

B.

I set the binder down. Take one breath.

*Evidence of change isn't trust.* I know this , I've processed enough litigation to understand that documentation proves behavior, not character. A paper trail can be manufactured. Verification chains can be constructed retroactively. People can learn to document and still not change. The fact that his handwriting is in the margins doesn't mean the handwriting is honest. The fact that I recognize his particular shorthand doesn't mean I can trust what the shorthand says.

I pick up the third binder.

Then the fourth. Somewhere between the third binder and the sixth, I stopped arguing with myself. I didn't decide to stop. It just became quieter , the counterarguments thinner, the margins closer together , and by the time I surfaced I was simply standing there, reading, the resistance already behind me without my having noticed it leave.

"You're early."

I close the binder too fast. Turn too fast. Everything too fast because my body didn't get the memo about professional distance and reasonable pulses.

Sam Reyes stands ten feet away.

He looks terrible. He looks wonderful. He looks like someone who hasn't been sleeping well, which I know because I haven't been sleeping well either and I recognize the particular shade of tired that comes from lying awake at 3 AM wondering if you ruined something irreparably.

His hair is longer than it was in February. Curling at the edges like it's given up fighting him. He's wearing a button-down shirt that doesn't quite fit right across the shoulders,either he's lost weight or he's borrowed someone else's clothes, and I don't know which option makes me feel worse.

"Harrison said 9:30." My voice comes out steadier than I expected. Court training. Years of speaking clearly while my hands shook under tables. "I like to review materials before formal walkthroughs."

"I know." He doesn't move closer. Stays exactly ten feet away like he measured the distance in advance. "You mentioned that. At the Chen settlement. Three years ago."

He remembers which settlement.

I file that information somewhere I'll deal with later. Probably at 3 AM, with the rest of the things I can't stop thinking about.

"The documentation is thorough," I say, because I need to say something and *I miss you so much I can't breathe sometimes* seems inadvisable. "The supplier verification chain. The independent testing confirmations. The margin notes explaining your methodology."

A muscle in his jaw moves once. "You read the margin notes."

"They're in the binders."

"They weren't supposed to be." He rubs the back of his neck,a nervous gesture I've catalogued a hundred times, usually preceding either an apology or an explanation he's still constructing. "Elena organized the documentation. She said the notes added 'context.' I told her they added 'embarrassment.'"

"Why embarrassment?"

He meets my eyes for the first time since he walked in. "Because you told me. Eight months ago. You told me exactly what I was doing wrong,trusting efficiency over verification, signing off on reports I hadn't traced back to source material, building my business on someone else's word instead of my own research. And I didn't listen because listening would have meant admitting I'd been doing it wrong for years."

The air between us changes , not warm exactly, but no longer the particular cold of two people avoiding something. More like the moment before a room is heated, when the radiator starts to tick.

It's not cold anymore. It's waiting.

Not cold since I walked in, since I saw his handwriting in those margins, since I understood that he'd done exactly what I'd asked him to do,not because I asked, but because I'd been right, and he'd finally let himself see it.

"So I went back," he continues. "Every project from the last eighteen months. Every compliance document, every supplier certification, every safety report. I traced them all to source. Found two other issues,not as serious as the glaze, but problems. Fixed them before they became problems. Started a new verification protocol for everything Mobility Workshop builds." He shrugs like this is normal, like this is small, like he didn't just describe rebuilding his entire professional methodology from scratch. "The margin notes were mostly me arguing with myself. About why I didn't do this sooner. About what it cost me to learn the hard way."

*What it cost me.*

I don't ask what he means. I don't have to.

The date is fixed in my chest like a pin through paper. Twenty-three days from now, I'll be allowed to decide things differently.

"The walkthrough starts in twenty minutes," I say instead. "We should probably,"

"Berna."

My name. Just my name. But the way he says it,

"I'm not asking for anything." He stays ten feet away. Doesn't move. Doesn't reach. "I know the timeline. I know why you needed it. I know that pushing would be exactly the wrong thing to do, and I'm trying very hard not to be the person who does the wrong thing anymore." A pause. "But I wanted you to know that I get it now. The trust thing. Why it matters. Why it mattered to you that I," He stops. Starts again. "I'm not asking you to believe me. I'm just asking you to look at the documentation."

"I already did."

"All of it?"

"The first two binders."

"There are six."

I stare at him. "Six verification binders? For one building project?"

"Elena called it 'overkill.' Then she called it 'pathological.' Then she stopped calling it anything and just started bringing me coffee at 2 AM because I wouldn't stop rechecking the supplier certificates." A ghost of a smile, there and gone. "I might have overcorrected."

"You built a paper trail that would survive a federal investigation."

"I built a paper trail that would survive you."

The words land somewhere between my ribs. Settle there. Start sending out roots.

The calendar sits in my head. May sits at the end of it. I made myself a promise about timelines, about deciding things based on evidence rather than fear, about not letting want outrun proof.

But the evidence is in those binders. Page after page of it. Six volumes of Sam Reyes learning to trust differently, documented in his own handwriting, annotated with his own arguments against himself.

"The walkthrough," I say. My voice isn't steady anymore. Hasn't been since he said *survive you*. "We should,"

"Yeah." He nods. Takes a step back, adding distance I didn't ask for. "Yeah, the walkthrough."

---

Harrison arrives at 9:28 with a tablet, a handshake, and an energy level that suggests either excellent coffee or complete emotional obliviousness. Possibly both.

"Wonderful to have the whole team together!" He beams at me like we're old friends. At Sam like they're business partners. At the Forge & Flow space like it's his personal achievement instead of months of other people's work. "Shall we begin?"

We shall.

The walkthrough is procedural. Mechanical. Harrison reads from his tablet; I confirm each specification against my original design documents; Sam or Elena (who appears midway through, carrying her own folder of verifications) provides installation confirmation. We measure door widths. We test ramp gradients. We verify that the bathroom stalls I redesigned three times have, in fact, been built to the exact specifications I finally approved.

Professional. Impeccable. Completely routine.

And through all of it, Sam stays on the opposite side of the space.

Not avoiding me, exactly. More like maintaining orbit. Close enough to see, too far to touch, circling the same center of gravity without ever intersecting. When I check the ramp railings, he's by the windows. When I move to the windows, he's at the front counter. When Harrison herds us all toward the back studio for final verification, Sam somehow ends up behind me and to the left,visible in my peripheral vision but never directly in my sightline.

It shouldn't be intimate. It's the opposite of intimate. It's two people not touching, not speaking, not looking at each other for longer than seconds at a time.

But I feel him there. The weight of his attention. The careful effort of his distance.

"The glazing meets all safety specifications," Harrison announces, tapping his tablet like he's personally responsible for glass technology. "Ms. Reyes provided excellent documentation."

Elena catches my eye across the room. Makes a face that very clearly says *he did all the documentation, Harrison just can't tell our signatures apart*.

I don't smile. I want to.

"I have some additional verification materials," Sam says. "For the lead counsel's files. If she wants them."

Harrison waves a hand. "I'm sure whatever you provided is,"

"I'll take them."

Everyone looks at me. Including Sam, finally, directly, his eyes meeting mine across the partially-renovated studio space.

"For the files," I add. Because I need to say something. Because the date on my calendar is an eternity and also nothing at all. "In case of future questions."

"Right." Sam reaches into the bag I hadn't noticed him carrying. Produces a folder,thick, tabbed, with a sticky note on the front. "I made copies of everything relevant. Supplier chains, testing certifications, the whole verification protocol we developed. In case you wanted to review it. For professional purposes."

*For professional purposes.*

I take the folder. My fingers brush his for approximately one-quarter of one second,not enough to count, not enough to acknowledge, just enough to remind my nervous system that he's real and solid and standing three feet away after two months of absence.

The sticky note on the front is yellow. The handwriting is his.

*B, Everything you asked for. Everything I should have done from the beginning. ,S*

I tuck the folder under my arm before Harrison can see it. Before Elena can see it. Before Sam can watch me read it again and again, memorizing the shape of his letters, the brevity of his words, the fact that he signed it with just an initial like we're teenagers passing notes instead of adults with legal complications.

"I think we're done here," Harrison announces. "Excellent work, everyone. The building inspector should have final approval by end of week."

He shakes hands. He thanks people. He does all the things competent project managers do at the end of successful walkthroughs.

And I stand in the middle of Forge & Flow with Sam's folder against my ribs and his sticky note burning through the paper.

---

Afterward.

Elena catches me in the parking lot. Not by accident,she was waiting, I can tell, positioned between my car and the exit like a very well-dressed checkpoint.

"He's going to kill me for this," she says. "But he's also been terrible for two months, so I figure I'm owed some interference."

"Elena,"

"He comes here every day." She cuts me off like I wasn't speaking. "Not to work on the project. That's done. He comes to check the documentation. To make sure nothing's changed, nothing's been moved, nothing's different from the last time he verified it. He made me promise not to tell you, but I'm terrible at promises and also he rewrote his entire company's safety protocol because you were right about something, so I think you should probably know that."

I don't know what to say.

*The number,* my brain supplies unhelpfully.

"I'm not trying to pressure you." Elena's voice softens. "Whatever you decide, whatever timeline you need,that's yours. He knows that. But I'm his sister, and I watched him work himself half to death over those verification binders, and I need you to understand that it wasn't about winning you back or proving something or any kind of,grand gesture." She says the last words like they taste bitter. "He genuinely believed he'd been doing it wrong. He genuinely wanted to fix it. Even if you never saw those binders. Even if you never came back."

"Why are you telling me this?"

"Because Marco says you've been sad." She shrugs like this is simple. Like sad is a condition with obvious treatments. "And because I hate when he's wrong about things, and he said you'd be at this walkthrough and you'd see the documentation and you'd understand. And I said that was ridiculous, that paperwork doesn't mean anything, that you can't fall in love with someone's margin notes."

She stops.

Looks at me.

"Was he wrong?"

I open my mouth. Close it.

The folder is still under my arm. The sticky note is still visible at the edge,*Everything you asked for.*

"Marco's been wrong before," I say finally. "About small things. Predictions. Which restaurant will survive a health inspection. Whether a particular client is telling the truth about their expenses."

Elena waits.

"He was wrong once about me. Two years ago. He told me I'd hate working at Hanover & Pryce because it was too corporate and I was too..." I search for the word. "Idealistic."

"Was he wrong?"

"I didn't hate it." I adjust the folder under my arm. "I just changed."

Elena nods slowly. Like I've answered something she wasn't quite asking.

"He hasn't looked at a calendar in weeks," she says. "But he knows the exact number."

"He told you that?"

"He didn't have to." A small, sad smile. "I know my brother. And I know what it looks like when he's counting down to something."

She walks away before I can respond. Which is probably intentional.

I stand in the parking lot for three more minutes. Looking at the folder. Looking at the building. Looking at the place where Sam was standing when he said *I built a paper trail that would survive you.*

Then I get in my car.

Drive back to the office.

Put the folder in my desk drawer, right next to the floor plan I drew in February.

---

That night, I do the thing I promised myself I wouldn't do.

I read all six binders.

Gloria had them couriered over after the walkthrough,"for the files," she said, with the same careful neutrality she uses for everything related to this case,and now they're spread across my living room floor at 11:47 PM, tabs and sticky notes and margin notes everywhere.

He was right. They're excessive.

Every supplier traced to source. Every safety standard cross-referenced. Every technical specification verified not once but multiple times, with dates and signatures and notes explaining his reasoning.

*Checked this three times. Still not sure it's enough.*

*B. would want proof, not promises.*

I set the binder down.

That one stops me. Not because it's the most significant thing I've read tonight,there are hundreds of notes, and most of them are more technically detailed, more thorough, more objectively impressive. But *B. would want proof, not promises* is written in the margin of a routine supplier re-verification. A document that no one ever needed to check twice. A check he ran anyway, months after the glaze crisis, for a subcontractor nobody had complained about.

He wasn't documenting for me. He was documenting like me.

I carry the binders to my office,next to the folder, next to the floor plan, next to every artifact of the last eight months that I can't bring myself to throw away.

The number on the calendar doesn't feel like a countdown anymore.

It feels like a runway.

$akm001ch16$,
  3275
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  17,
  'Chapter 17',
  $akm001ch17$
# Chapter 17

The taxi drops me at Forge & Flow at 7:14 AM because I have made a spreadsheet.

Not a metaphorical spreadsheet. An actual Excel document, color-coded, with seventeen rows detailing the items I left at Sam's workstation over the past three months. One legal pad (yellow, half-used). Three pens (Pilot G2, 0.7mm, black). A phone charger. A cardigan that I told myself I'd forgotten but actually left there on purpose because it smelled like sawdust and coffee and something else I refused to name.

The spreadsheet exists because I needed a reason to go back. A legitimate, documentable, plausibly deniable reason that would hold up under cross-examination from my own conscience.

*Your Honor, I was simply retrieving my property.*

*The fact that I read six verification binders until 2 AM has no bearing on this decision.*

*The evidence will show that my cardigan is, in fact, mine.*

I'm aware that this is insane. I'm aware that normal people don't need legal justification to visit someone they've been deliberately not visiting for three months. But Berna Alvarez does not show up anywhere without a documented purpose, and my documented purpose is: spreadsheet.

The building is quiet at this hour. The coffee shop on the ground floor hasn't opened yet, which means the lobby smells like cleaning solution instead of espresso. The elevator makes its familiar mechanical groan. I know which floor to press without thinking.

I've been here before. Many times. But this feels different.

Because I am different.

Because I spent six hours reading about Sam Reyes in his own handwriting, and I found exactly zero reasons to run.

---

The third floor is empty.

Of course it is. It's 7:14 AM on a Wednesday. The other tenants,the graphic design firm, the podcast startup, the accountant who exclusively wears Patagonia vests,won't arrive for at least two hours. I know this because I have been tracking arrival patterns since November. Not intentionally. Just... observationally. The way you notice things about places where you've spent a lot of time not admitting that you're spending time there.

Sam's corner is at the far end.

I walk toward it. My heels click on the concrete floor,a sound that used to announce my arrival, that used to make him look up from whatever prototype he was testing and smile like I'd brought good weather. I haven't heard that click in twenty-three days.

His desk comes into view.

My hands go still at my sides.

It's exactly the same. Which shouldn't surprise me,people don't reorganize their entire workspace in three weeks,but somehow I expected it to look different. Emptier. Sadder. Some physical evidence of the distance I'd demanded.

Instead: chaos. The beautiful, productive chaos of Sam Reyes at work.

Sketches everywhere. Pinned to the corkboard, scattered across the desk, taped to the partition wall. Some I recognize from before,early concepts for the handle system, the rejected wheel designs, the user feedback diagrams. But some are new.

A lot of them are new.

I move closer. My spreadsheet of belongings temporarily forgotten.

The new sketches show a grip system I've never seen. More ergonomic. The angle is different, gentler on the wrist. There are annotations in Sam's handwriting,messy, excited, the letters getting bigger when he's onto something:

*Tested with arthritis simulation*
*Claire says easier for her aunt*
*COATING FIXED,see sample*

And next to the last note, circled three times:

*Works better. Feels right. Don't compromise on this one.*

I touch the paper without meaning to.

---

The prototype is on his workbench.

I know I shouldn't look at it. I'm here for my cardigan and my legal pad and my Pilot G2s,my seventeen documented items, catalogued and spreadsheet-verified. I'm not here to examine his work. I'm not here to find evidence.

But the prototype is *right there*, and Berna Alvarez has never successfully walked past evidence in her entire life.

It's a walker handle. The same model I've seen him test a hundred times,the one he designed for stroke survivors, the one that went to user testing last month. But this version is different.

The coating is different.

I pick it up.

The surface is softer than before. Not soft in a way that compromises grip, but soft in a way that... accommodates. That allows for shaking hands, weakened fingers, unreliable muscle control. I turn it over. The metal underneath is the same, but the coating adds forgiveness.

I think about the verification binders. Section 2.3: *Material science review scheduled. Focus on surface textures that accommodate variable grip strength.*

He wasn't writing about the business. He was writing about the people who would use it.

He was making the work better so that the trust was justified.

I set the handle down. My hands are shaking slightly. Not with anxiety,with recognition. The feeling of finding evidence that supports a conclusion you wanted to reach but were too afraid to assume.

*This is who he is now.*

*This is who he's been becoming while I demanded distance.*

*This is what he built while I was reading his binders at 2 AM and pretending I was still deciding.*

---

The partition wall is where we used to leave messages.

Not love notes. Post-its. The most unsexy form of communication ever invented, and somehow Sam Reyes turned them into a whole thing.

It started in November, before the contract was signed. I'd demanded changes to the first draft,Sam's version was too loose, too many undefined terms,and he'd responded by leaving a Post-it on my laptop: *Your clause is showing.*

I'd left one on his coffee mug: *Your methodology is questionable.*

He'd stuck one on my legal pad: *Your precedent has been cited.*

By December, the partition wall was covered in them. Yellow squares, blue squares, pink squares when he was feeling particularly antagonistic. A physical record of our entire relationship, in miniature.

*Wednesday: Remember to eat lunch.*
*Very professional concern, Mr. Reyes.*
*Professionalism is my brand.*
*Your brand is chaos.*
*Says the woman who color-codes her chaos.*
*That's not chaos. That's strategy.*
*Sure it is.*

I haven't left a Post-it in twenty-three days.

Neither has he. The wall looks the same as it did the last time I was here,mid-February, before the gap, before I demanded space to think. The most recent one is still visible, slightly curled at the edges:

*Consortium dinner Tuesday. I'll pick you up at 6.*
*That wasn't a question.*
*It was a statement.*
*Statements also require consent.*
*Berna Alvarez. Will you let me pick you up at 6 for the Consortium dinner on Tuesday, with the full understanding that this request complies with all applicable sections of our contract and does not constitute any form of pressure, coercion, or assumption?*
*Fine.*
*Was that a yes?*
*That was a fine.*
*I'll take it.*

I read the exchange three times.

Then I pull a Post-it from the stack on his desk,yellow, the classic,and I uncap a pen.

---

Writing is harder than I expected.

The pen hovers. The Post-it waits.

I think about the binders. Six of them. Blue tabs for structural items, yellow for methodology, green for timeline, orange for risk mitigation, pink for stakeholder communication, red for verification criteria.

I think about Elena's handwriting in the margins: *Sam actually doing the work.*

I think about the prototype on his workbench. The softer coating. The grip that forgives.

I think about three months of Post-its on this wall, and how somewhere along the way, I stopped noticing that they'd become the closest thing I had to a love language.

My hand moves.

*For the record: I didn't mind the queue.*

I stick it to the wall.

It looks small. Smaller than it felt to write. Eight words that don't explain anything,not the binders I read, not the night I spent sitting with his evidence, not the three weeks I spent telling myself I was still deciding while my body already knew the answer.

But Sam will understand.

Sam always understands the things I don't say directly.

---

I'm gathering my cardigan,item seven of seventeen,when I hear the elevator.

My stomach drops. Not in fear. In something more complicated. The feeling of being caught in the middle of an action you were trying to complete before facing its consequences.

The elevator doors open.

Footsteps on concrete.

I should grab the rest of my items and leave through the back stairwell. I should avoid this conversation entirely. I should,

"Berna?"

He's carrying coffee. Two cups. The same order we've been getting for three months,black for him, oat milk latte for me, an unspoken accommodation that started in November and never stopped.

Why does he have two cups?

"I was retrieving my belongings," I say. My voice is steady. My legal training kicks in automatically,neutral tone, defensible statement, no admission of intent. "Per the termination clause, I retained ownership of all personal items left on premises."

Sam looks at me. Then at the cardigan in my hands. Then at the partition wall.

He sees the Post-it.

I watch his face change. The careful blankness he's been maintaining since March,the respect for my distance, the space I demanded,cracks open. Just for a moment. Something raw underneath.

"You came back," he says.

"I came to collect my things."

"You left a Post-it."

"That seemed... relevant. To the historical record."

He sets both coffees down on the nearest desk. His hands are deliberate. He's moving slowly, like I'm something that might startle. Like three weeks of silence have taught him to be careful with me.

"The queue," he says. "That's what you wrote about."

"You made it very clear that there was a queue. Early in the negotiation process. I felt it was appropriate to document my position on that queue."

"Your position being..."

I swallow. "That I didn't mind it. The waiting. Even when," The words catch. I force them through anyway. "Even when I pretended that I did."

---

He crosses the space between us.

Not all of it. Halfway. Then he stops.

Three feet away. Close enough to touch, if either of us reached. Far enough that neither of us has to.

"I read the binders," I say. Because apparently I'm confessing things now. "Marco brought them. Day Twenty-Three. I read all six of them, and it took me until 2 AM, and I kept waiting for the part where it fell apart."

"Did it?"

"No." My voice cracks slightly. I let it. "It didn't fall apart. You documented everything. The methodology review, the material science changes, the user testing improvements. You built verification criteria into your own process. You made the work better so that the trust would be justified."

"Yeah." Sam's voice is rough. "That's what I was trying to show you."

"I know." I'm shaking. When did I start shaking? "I know that now. I knew it when I finished reading. I knew it when I looked at the prototype on your workbench. The new coating,the one that accommodates variable grip strength,that's what you've been working on. That's what Section 2.3 was about."

"You looked at my prototype?"

"I look at everything. It's a professional liability."

He almost smiles. Almost. "Berna."

"The binders were evidence," I continue, because apparently I can't stop talking now that I've started. "Documented, verified, cross-referenced evidence. You built a case. A real case. The kind I would build if I were trying to prove something that mattered."

"I was trying to prove something that mattered."

"I know." My voice breaks fully this time. "I know you were. And I spent twenty-three days telling myself I needed more time, more data, more certainty. But the truth is," I take a breath. "The truth is, I've known since January. I've known since you handed me that first draft of the contract and I wanted to find reasons to reject it and couldn't. I've known since November, probably. Since the first Post-it. Since you called my clause 'showing' and I laughed instead of objecting."

"Berna."

"I'm not good at this," I say. "I'm not good at uncertainty. I'm not good at trust without documentation. I'm not good at," I gesture between us. "Whatever this is. Whatever this has been. I needed distance because I was terrified, and I needed evidence because I don't know how to believe things without it, and I needed you to prove that you'd changed because I couldn't survive being wrong again. But you did prove it. You built six binders and a better prototype and you waited while I panicked, and now I'm standing in your workspace at 7 AM holding my cardigan and I don't actually care about the cardigan, Sam. I care about,"

I stop.

He's close enough that I can see the details of his face. The circles under his eyes,he hasn't been sleeping either. The tension in his jaw,he's holding himself still on purpose. The way his hands are shaking,

His hands are shaking.

"Berna." His voice is very quiet. "Why did you really come here?"

"To collect my things."

"Why did you really come here?"

The question hangs between us. Three feet of distance. Twenty-three days of silence. Three months of pretending.

I could lie. I'm good at lying. I'm good at contracts and clauses and plausible deniability.

But I'm so tired of being good at that.

"To cross the distance," I say.

---

I reach for his hand.

It's not accidental. It's not momentum. It's not the kind of touch that happens to people,the brush of fingers in a crowd, the incidental contact of shared spaces.

This is deliberate.

This is chosen.

Berna Alvarez does not take hands accidentally.

My fingers find his. They're warm. Calloused from work, from prototypes, from building things that help people. Shaking slightly, the same way mine are shaking. I don't know which one of us is trembling harder.

His hand closes around mine.

Not tight. Not possessive. Just... there. Present. Holding on the way you hold something you've been waiting for.

"For the record," I say, and my voice is steadier than I expected, "this constitutes a material change to the terms of our arrangement."

He laughs. Actually laughs,the sound cracking through three weeks of careful distance.

"What are the new terms?"

"I haven't drafted them yet."

"You're drafting contract amendments at 7 AM?"

"I'm always drafting something. It's a professional condition."

His thumb traces a circle on my palm. Small. Deliberate. The kind of touch that means something.

"What if I propose some terms?"

"You're not a lawyer."

"I'm a pretty good negotiator."

"Your last contract had seventeen deficiencies."

"And you fixed all of them." He's smiling now. Actually smiling,the smile I haven't seen in twenty-three days. "Berna. I have a proposal."

"I'm listening."

"New terms. No termination clause. No verification binders,or actually, keep those, you seemed to like them. But no more distance. No more pretending we don't know what this is."

"What is this?"

He lifts my hand. Turns it over. Presses his lips to my palm,the gesture so unexpected, so tender, that I forget to breathe.

"Whatever you want it to be," he says against my skin. "Whatever you're ready to call it. I'll wait for you to find the right words."

"I have words."

"I know you do."

"I have a lot of words. It's a professional hazard."

"So tell me one."

I look at him. At his face, his hands, his workspace full of sketches and prototypes and evidence of change. At the partition wall covered in Post-its,three months of conversation, documented in yellow and blue and pink squares. At the newest addition: *For the record: I didn't mind the queue.*

"Real," I say.

"Real." He says it back like he's testing the weight of it. "I have to tell you, I rehearsed four different responses for if you said real, and all of them were terrible, so I'm going to , I'm just going to,"

He closes the remaining distance between us.

"I have more," I say.

"I'm listening."

"Not fake," I say. "Not contracted. Not strategic. Not," I take a breath. "Not something I can put in a spreadsheet and pretend I chose for practical reasons."

"What did you choose it for?"

The question is soft. He already knows the answer. But he's asking anyway, because he understands that I need to say it. That I need to document it. That Berna Alvarez doesn't believe things until she's articulated them clearly.

"Because I want to," I say. "Because I wanted to from the beginning. Because every time I found a reason to object, I couldn't make myself object. Because you kept showing up with two coffees even though we weren't speaking, and I spent three weeks pretending I wasn't counting the days until I could stop pretending."

"Twenty-three," he says.

"What?"

"Twenty-three days. I was counting too."

---

The coffee is cold by the time either of us drinks it.

We're sitting on his workbench,unprofessional, undignified, completely out of character for someone who color-codes her chaos. But I don't care. I'm holding cold coffee and his hand and both feel right.

"The prototype," I say. "The new coating. When did you finish it?"

"Day Eighteen."

"The binders say Day Twelve."

"The materials arrived early." He's not looking at me,he's looking at our hands, tangled together like this is something we've always done. "I couldn't sleep. I kept thinking about what you said. About the work. About how it wasn't enough to change the pattern if I didn't change the foundation."

"I said that?"

"You said a lot of things. I wrote most of them down."

"In the binders?"

"In a separate document." He glances at me. Almost sheepish. "It's not as organized as yours would be."

"I would hope not."

"I called it 'Things Berna Told Me That I Needed To Hear.'"

I laugh. Actually laugh,the sound surprising both of us. "That's a terrible file name."

"I'm not a lawyer. I don't have your filing system."

"Clearly."

He turns my hand over. Studies my palm like it contains evidence. "When did you decide to come back?"

"This morning."

"Liar."

"I made a spreadsheet."

"Of course you did."

"Seventeen items. Color-coded. Very professional."

"And the Post-it?"

I don't answer immediately. The Post-it is still on the wall, yellow and small and carrying more weight than eight words should.

"Somewhere around 2 AM," I admit. "When I finished reading. I knew I was going to write something. I just didn't know what."

"You wrote about the queue."

"Because that's what mattered." I meet his eyes. "You waited. Even when I couldn't tell you why I needed you to wait. Even when I couldn't document a timeline for when I'd stop needing distance. You built verification binders and a better prototype and you waited without demanding to know when the waiting would end."

"That's what you do," he says. "When something matters."

"I know." My voice is quiet. "I just never expected anyone to do it for me."

---

The sun shifts through the windows.

8 AM. The building is starting to wake up. I can hear the coffee shop opening downstairs,the familiar sounds of espresso machines and morning conversation. Soon the other tenants will arrive. The graphic designers, the podcast people, the accountant in Patagonia.

Normal life, continuing.

"I should go," I say. But I don't move.

"Stay."

"I have work."

"Stay anyway."

I look at him. At the certainty in his face, the steadiness in his voice. At the way he's holding my hand like he has no intention of letting go.

"I could stay an hour."

"Or longer."

"Sam."

"Berna." He's smiling. "What would your spreadsheet say about this?"

"It wouldn't say anything. This isn't a spreadsheet situation."

"What is it?"

I lean in. Slow, deliberate, the same way I reached for his hand. The kiss is small,barely a kiss, just the brush of lips against the corner of his mouth. But it's enough.

It's everything.

"This is real," I say against his skin. "That's what it is. We can figure out the rest later."

His hand comes up to cup my jaw. Gentle, careful, the way he handles his prototypes. The way he handles things that matter.

And then he kisses me properly,not the brush of lips, not the almost-touch from all those months ago, but the real thing. The thing I've been waiting for without admitting I was waiting.

I kiss him back.

The morning light spills through the windows of Forge & Flow. The Post-it watches from the partition wall. The cold coffee sits forgotten on the workbench.

And Berna Alvarez, for once in her life, doesn't need documentation to believe that something is true.

$akm001ch17$,
  3442
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  18,
  'Chapter 18',
  $akm001ch18$
# Chapter 18

We leave Forge & Flow through the back door because neither of us can wait for the polite choreography of saying goodbye to strangers. Sam's hand stays in mine,deliberate, chosen,and the April air hits us like a slap of reality that changes nothing.

"My place," he says. "It's closer."

"How do you know where I live?"

"I don't. I'm gambling."

"What if I live next door?"

"Then I'll feel stupid for exactly three seconds and then I won't care." His thumb traces circles against my palm. "Berna. My place?"

"Yes."

The cab ride takes eleven minutes. I know because I count them, watching the city blur past in streaks of neon and headlights, hyper-aware of every point where his body touches mine. His thigh against my thigh. His shoulder against my shoulder. His hand, still holding mine, resting on the seat between us.

Halfway through, I take out my phone.

"We should update the disclosure situation properly," Sam says. "On Monday."

"Already handled. I sent the updated form from the cab."

He stares at me. "You filed paperwork during our cab ride?"

"It seemed efficient."

He laughs once,surprised, quiet,and then shakes his head and doesn't let go of my hand.

When we pull up to his building,a converted craftsman in the Hawthorne neighborhood that I've never seen before,he pays the driver with a twenty and doesn't wait for change. I follow him up three flights of stairs, watching the way he takes them two at a time, keys already in his hand.

"I should warn you," he says, unlocking the door, "my apartment looks like a design student exploded inside a very nice library."

"Is that a threat or a promise?"

"Both." He pushes the door open and steps aside to let me in first. "Also there might be a very judgmental cactus on the windowsill. His name is Gerald. Don't let him intimidate you."

The apartment is exactly what I expected and nothing like what I expected. Exposed brick walls lined with overflowing bookshelves. A massive drafting table covered in sketches and Post-its. Mismatched furniture that somehow works together,a deep green velvet couch, a coffee table made from reclaimed wood, a reading chair that looks like it's been sat in approximately ten thousand times.

"Gerald seems reasonable," I say, nodding at the small cactus on the windowsill.

"He's not. He judges everyone." Sam closes the door behind us and for a moment we just stand there, the two of us in his space, the city muffled by walls and distance. "Can I get you something? Water, wine, the complete works of Shakespeare annotated with my increasingly unhinged margin notes,"

"Sam."

He stops. Looks at me.

"We don't need to do the bit," I say. "The banter. The deflection. We can just," I take a breath. "I'm nervous."

His whole face softens. "Me too."

"Good. I'd hate to be nervous alone."

He crosses to me slowly, giving me time to change my mind. I don't. When he's close enough to touch, he reaches up and traces the line of my jaw with his fingertips, so gentle it makes my chest ache.

"Last time," he says quietly, "I didn't know what I was doing. I mean, I knew what I was doing,I've done the thing before,but I didn't know it was *this*. I didn't know I was falling in love with you."

"And now?"

"Now I know." He cups my face in both hands. "Now I know exactly what this is. Which should make it easier, but actually just makes me terrified of getting it wrong."

"Sam." I put my hands over his. "You're not going to get it wrong."

"How do you know?"

"Because we already survived wrong. We survived the worst possible version of wrong." I turn my head and press a kiss to his palm. "Everything from here is extra credit."

He laughs,a small, surprised sound,and then he kisses me.

The first time we did this, in that dim workshop, there was a frantic quality to it. Discovery. Exploration. The giddy rush of *yes, this works, this body fits against this body in ways I didn't expect*. We learned each other in shorthand, guessing and adjusting, figuring out the shape of something new.

This is different.

His mouth finds mine and I *know* him now. I know the way he kisses like he's asking a question and waiting for an answer. I know the sound he makes when I bite his lower lip, that small hum of approval that vibrates against my teeth. I know the way his hands move to my waist, pulling me closer with exactly the right pressure.

"Bed," I say against his mouth.

"Down the hall. Left. Unless you want the couch, which I should warn you has a structural weakness that,"

"Sam."

"Bed. Yes. Good."

We move through his apartment without separating, a complicated dance of mouths and hands and furniture obstacles that somehow doesn't result in injury. His bedroom is small and lived-in,unmade bed, books stacked on the nightstand, a truly impressive quantity of blankets,and when we tumble onto it together, I have the fleeting thought that I've never been in a bed that felt more like *him*.

He pulls back just enough to look at me, propped on his elbow, eyes roaming over my face like he's memorizing something.

"What?" I ask.

"Just looking." He brushes hair from my forehead. "I spent a month not being able to look at you. Or, being able to look but not letting myself. Which was worse."

"I know. I did the same thing."

"I noticed." His smile is rueful. "You're very good at not looking at someone while being extremely aware of where they are in the room at all times."

"Years of practice."

"At not looking at me specifically?"

"At not looking at things I want."

His breath catches. "Berna."

I reach for the buttons of his shirt, methodical, deliberate. "I'm done not looking at things I want."

He lets me undress him, staying very still except for the rapid rise and fall of his chest. I take my time. Unfasten each button like I'm reading a contract, finding the important clauses. Push the fabric off his shoulders and trace the topography of his collarbones, the muscles of his chest, the soft curve of his stomach.

"You're staring," he says.

"Yes."

"It's a lot of pressure."

"You'll survive." I press my palm flat against his sternum, feeling his heartbeat. "I like that you're nervous."

"I'm not nervous, I'm," He exhales. "Okay, I'm nervous. But also I'm experiencing approximately seventeen emotions simultaneously and I don't have words for most of them, which is distressing because words are my whole thing, and,"

I kiss him. He stops talking.

"Better?" I ask.

"Marginally. Do it again."

I do.

We shed the rest of our clothes in a tangle of cooperation that would have been awkward a month ago but isn't now. His hands find my zipper without fumbling. My fingers know the shape of his belt buckle. When we're finally bare against each other, skin to skin in his unmade bed, it feels less like revelation and more like homecoming.

"Hi," he whispers.

"Hi."

"This is going to sound ridiculous, but I missed you."

"We saw each other every day."

"I know. I missed you anyway." He traces patterns on my shoulder blade. "I missed being able to touch you. I missed that thing you do when you laugh,really laugh, not the polite one,where your nose crinkles up."

"It does not."

"It absolutely does. It's devastating. I've been devastated for a month."

I kiss his nose, then his forehead, then the corner of his mouth. "I missed your tangents."

"Okay, now I know you're lying."

"I'm not. I missed the way your brain works. How you connect everything to everything else." I trace the line of his jaw. "I missed being the person you connected things to."

He rolls us so I'm beneath him, his weight a familiar pressure, his eyes very dark. "Berna Alvarez. I'm going to say something now and I need you not to make fun of me."

"No promises."

"Fair." He takes a breath. "I love you. I know I said that at the party, but I need you to know I mean it here, now, sober, not in crisis mode. I love you and it's not because you're beautiful, although you are, and it's not because you kissed me, although I liked that part, it's because," He pauses, searching. "You argue with me. Not to win, but because you actually care about being right. You challenge every stupid thing I say and you make me work for it and I've never felt more respected in my entire life."

I blink at him. "That's the most romantic thing anyone's ever said to me."

"See, that's concerning. Your standards should be higher."

"Shut up. I love you too."

His jaw shifts, the relief landing visibly before the rest of him catches up,eyes going bright in a way that's dangerously close to tears. "Yeah?"

"Yeah." I pull him down to me. "Now stop talking."

For once, he listens.

---

Making love to someone you know is different than making love to someone you're discovering.

I learned that the first time, in his workshop,the specific way his body responds, the sounds he makes, the rhythm he prefers. I catalogued it without meaning to, filed it away under *things I can never think about again*.

But bodies forget what minds remember. Or maybe the reverse. Either way, when his hands move over me now, there's none of the hesitation from before. He knows where to touch. I know how to arch into it. We fit together like we've done this a hundred times instead of once.

"Tell me what you want," he murmurs against my throat.

"You."

"More specific."

"This." I guide his hand lower. "Here. Like that."

He follows instruction. He's always been good at that, actually,better than his chaotic energy would suggest. When his fingers find the right pressure, the right angle, I make a sound that I'd be embarrassed about if I had any pride left.

"Good?" he asks.

"Don't fish for compliments."

"I'm absolutely fishing for compliments. Tell me I'm good at this."

"You're adequate."

"Adequate!" He laughs against my skin. "I'm giving you adequate? That's," He does something with his hand that makes me gasp. "How about now?"

"Improving."

"You're impossible." But he's smiling, and his hands don't stop, and when I finally shatter apart under his touch, he watches me with an expression that's equal parts wonder and satisfaction.

"Adequate," I manage, when I can speak again.

"You're such a liar."

I pull him up and over me, wrapping my legs around his waist. "Prove you're better than adequate."

"Is that a challenge?"

"Consider it a performance review."

He laughs,really laughs, the kind that crinkles his nose,and then he pushes into me and I stop thinking in complete sentences.

This. *This* is what I missed. Not just the physical mechanics, but the way it feels to be known while being touched. He moves with intent now, no guessing, reading my responses like text on a page. When I grip his shoulders, he slows down. When my breath hitches, he angles differently. When I say *there, yes, like that*, he commits it to memory.

"I love you," he says, voice ragged. "I love you, I love you, I,"

"I know." I pull him closer, bury my face in his neck. "I know."

We finish together,or close enough that it doesn't matter,and afterward, tangled in his ridiculous quantity of blankets, I feel something I haven't felt in years.

Safe.

Not safe as in nothing bad will ever happen. Safe as in: whatever happens, I won't be alone.

"That was significantly better than adequate," I tell the ceiling.

"I'll accept it." He rolls onto his side, props his head on his hand. "For the record, you're also significantly better than adequate."

"I know."

"The confidence. It's devastating."

"I've been told." I trace shapes on his chest,constellations, contract clauses, nothing in particular. "What happens now?"

"Now we lie here for a while and I resist the urge to spiral about whether I performed well enough to,"

"Not in bed. I mean with everything. The company. The lawsuit. Gloria."

He's quiet for a moment. "The settlement came through yesterday. Dev's team accepted the terms,restructured NDA, mutual non-disclosure, financial compensation that won't bankrupt anyone. It's done."

I sit up. "It's *done*?"

"Gloria called me this morning. Well, she called at 6 AM, which felt aggressive, but that's Gloria." He reaches over to his nightstand and pulls out his phone, scrolling through messages. "Here. She asked me to show you this."

It's an email. Three sentences.

*Reyes. Tell Alvarez her approach worked. Honesty as architecture,who knew. We're keeping you both.*

I read it twice. "She wrote that?"

"In her own terrifying hand, yes."

"She never writes."

"I know. I think she might have feelings."

I lie back down, staring at his ceiling, processing. The career survived. The architecture held. Everything I was afraid of,losing my job, losing my credibility, losing the careful structure I'd built,none of it happened.

"I thought we'd be fired," I admit.

"So did I. For about a month straight." He takes his phone back, sets it aside. "But it turns out that when you tell the truth about something complicated, people occasionally appreciate it. Weird. Revolutionary, almost."

"Don't let it go to your head."

"Too late. I'm already planning my TED Talk. 'Honesty: The Radical Strategic Framework That Will Destroy Your Enemies and Win Your Lover.'"

"That's a terrible title."

"All TED Talk titles are terrible. That's the point."

I roll toward him, press my face against his chest. He wraps his arms around me automatically, like it's muscle memory, like we've done this a thousand times.

"We made it," I say.

"Yeah." His voice is soft. "We did."

"I didn't think we would."

"Neither did I. I planned for failure. I had a whole speech prepared about how I'd wait for you, how I'd prove I was worth the risk, how,"

"You had a *speech*?"

"Three versions. I workshopped them with my sister. She said they were too dramatic but I think she secretly loved them."

"Oh my God."

"Version two rhymed. Not intentionally, it just happened, and then Elena pointed it out and I had to scrap the whole thing because it sounded like a bad country song."

"I can't believe you were preparing speeches while I was preparing exit strategies."

"Exit strategies?" He pulls back to look at me. "You were going to leave?"

"I was going to ask for a transfer. Different floor, different team, different building if they'd give it to me." I shrug, as much as I can while horizontal. "I couldn't figure out how to be near you without touching you. I thought distance was the only solution."

"That's the saddest thing I've ever heard."

"It was practical."

"It was tragic. You were going to exile yourself to,what, contracts? Regulatory compliance?"

"Immigration law. The LA office."

He stares at me. "LA."

"It was a dramatic option."

"It was a *terrible* option. The Powell's commute alone should have ruled it out." He pulls me closer, fiercely. "You belong here. You belong with me. You belong in Portland where Powell's exists and everything is fine."

"The Powell's argument is persuasive."

"It's the only argument that matters."

I kiss him, slow and thorough, just because I can. Just because there's no one stopping me. Just because the wall is down and the career survived and we made it.

"I love you," I say against his mouth.

"I love you too." He grins. "Was that adequate?"

"Significantly better than adequate."

"I'll take it."

We stay like that for a while, wrapped in blankets and each other, not talking. The city hums outside his window,traffic, sirens, the bass-line of a bar three blocks over. His heartbeat steadies under my palm. I watch the ceiling and let myself feel something I've been afraid of for so long I forgot it was fear.

Joy.

Pure, unguarded, earned.

"Sam," I say eventually.

"Mmm."

"I should tell you something."

He tenses slightly. "Okay."

"It's nothing bad. It's just," I take a breath. "I'm not good at this. The relationship part. I've never been good at it. I work too much and I forget to call and I get caught up in cases and I have a tendency to think I know best even when I don't."

"You do know best. Most of the time."

"I'm trying to warn you that I'm difficult."

"Berna." He props himself up on his elbow, looking down at me. "I know you're difficult. I've been working with you for seven months. I've seen you reduce a partner to tears over a misplaced comma."

"That comma changed the meaning of the entire clause."

"I know. It was hot."

I laugh despite myself. "You have strange taste."

"I have excellent taste. I chose you." He traces my cheekbone with his thumb. "Listen. I'm also difficult. I spiral about things that don't matter and I make jokes when I should be serious and I have a deeply unhealthy relationship with my own anxiety. But we're going to figure it out. Together. Because that's what this is now."

"Together."

"Yeah." He kisses my forehead. "Together."

I close my eyes. Let it sink in. The weight of that word, the structure of it. Together. Not a contract with exit clauses. Not a term sheet with conditions. Just two people choosing each other, over and over, until choosing becomes habit becomes instinct becomes home.

"Okay," I say.

"Okay?"

"Okay." I open my eyes. "Let's figure it out."

He smiles,that stupid, wonderful smile that I've been pretending doesn't affect me for seven months.

"First step," he says. "We should probably tell HR."

"Oh God."

"You have to fill out the disclosure forms. I've read them. They're extensive."

"I've drafted those forms."

"I know. I noticed you included a section about prior romantic entanglements. Very thorough."

"It's relevant information."

"It's also deeply ironic given current circumstances." He's laughing now. "You're going to have to fill out your own forms. In triplicate."

"I hate you."

"No, you don't."

"No," I admit. "I don't."

He kisses me again, still smiling, and I think: *this*. This is what all the structure was protecting. This is what I was so afraid to want.

Not the chaos. The love inside it.

The career survived. The architecture held. And somewhere between that workbench and this unmade bed, I figured out something I should have known all along.

Some things are worth the risk.

---

Later,hours later, after we've exhausted ourselves and ordered bad Thai food and eaten it in bed like the irresponsible adults we've become,my phone buzzes with a text from Gloria.

*Enjoy your weekend, Alvarez. Monday we rebuild.*

I show it to Sam.

"That's practically effusive," he says. "For Gloria."

"I think she might be happy for us."

"That seems statistically unlikely."

"Maybe she just appreciates the reduced HR liability now that we've disclosed."

"Ah yes. Romance: the risk mitigation strategy."

I elbow him. He catches my arm and pulls me close, pressing his nose to my hair.

"Hey," he says.

"Hey."

"I'm glad you wrote on the Post-it."

"I'm glad you knocked on my window."

"It was a good system."

"It was a ridiculous system."

"Same thing." He yawns against my shoulder. "Sleep now. Rebuild Monday."

"That's practically poetic."

"I have hidden depths."

"You have hidden exhaustion."

"Also that."

I close my eyes. His arms stay around me. The city hums. Gerald the cactus judges from the windowsill.

And for the first time in longer than I can remember, I fall asleep without worrying about what comes next.

$akm001ch18$,
  3310
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  19,
  'Chapter 19',
  $akm001ch19$
# Chapter 19

---

The disclosure form is four pages long. I know this because I wrote it.

Not this instance of it , the template. Section 2.4 of the firm's conflict-of-interest policy, the paragraph that begins *In the event that a supervising attorney develops a personal relationship with a client or former client of the firm*, and then continues for nine lines of subordinate clauses that I personally restructured in 2022 because the previous version had a dangling modifier in the third sentence and I could not let that stand.

I am now filling it out in triplicate.

The irony is not lost on me. It is, in fact, sitting directly in front of me at 8:47 AM on a Monday in late April, drinking my coffee and waiting for me to notice it. I notice it. I fill out the form anyway, because that is what you do with irony: you acknowledge it and then you complete the relevant paperwork.

*Nature of relationship:* Personal.

*Date relationship commenced:* I write the date and then pause. Commenced is technically ambiguous. Did it commence when Sam knocked on my window, or when he peeled the Post-it off my door, or when I sent the updated form from the cab? I write the window date. It's the most defensible.

*Does the relationship create a direct or indirect conflict with current client matters?* No, because I have already transferred the Mobility Workshop file to a partner with no prior client contact and filed the appropriate case reassignment notice, which I did on Friday before 5 PM because I am a professional.

I sign the triplicate. I submit. I refill my coffee.

At 9:23, Gloria's email arrives.

*Alvarez , Form received and processed. Equity track review has been rescheduled to Q3. The Reyes matter is yours if you want it; Rafael Reyes asked for you specifically. ,GL*

I read it twice. The first read is for content. The second read is for the clause I didn't expect: *The Reyes matter is yours if you want it.* Rafael Reyes is a $40M patent dispute that three senior associates have been circling for two months. Gloria does not offer files as comfort. Gloria offers files as assessment. She is telling me she has done the math on the situation and the math checks out.

I write back: *Understood. Reyes, yes. ,BA*

She responds in forty seconds: *Obviously.*

I add it to my calendar.

---

Sam comes in at eleven to sign the amended settlement documents , Dev Chen's team wanted initialed copies of the final restructured NDA, which technically required an in-person signature from the restructuring attorney of record, which is now Marcus Paulsen, but the paperwork ran through our office and someone had to be there to witness.

I am not the someone. I am at my desk, fifteen feet from the conference room, when Sam walks past.

Gloria is in the hallway.

I watch this from my desk with the specific attention I give to depositions I cannot interrupt.

Gloria looks at Sam the way she looks at contracts she hasn't signed yet , measuring, noncommittal, taking in the fine print. Sam sees her, stops, extends his hand. "Sam Reyes," he says. "You're Gloria Leary." Not a question.

"I am." She shakes his hand once. "Your CeraTest situation was resolved appropriately."

Sam says: "Your associate is exceptional. I don't think the situation gets resolved without her."

Gloria looks at him for two seconds , which is one second longer than she looks at most people. "No," she says. "It doesn't."

She continues down the hallway. Sam watches her go with the expression of a man who has just been evaluated by a large and impartial animal and found acceptable.

He glances over at me. I give him nothing. He mouths: *was that a compliment?*

I mouth back: *yes.*

He looks genuinely surprised. I return to my contract.

---

Elena shows up at Sam's apartment at seven carrying a bottle of wine and the energy of someone who has been waiting patiently for weeks to ask questions she was not previously permitted to ask.

Sam is in the kitchen attempting risotto. I know he is attempting risotto because he told me so, specifically, in the text he sent at 5 PM: *making risotto, i watched four videos, i have a plan.* I have since been observing the plan in action, which involves a Le Creuset he definitely does not know how to use, three different wooden spoons that he keeps switching between for reasons that are unclear even to him, and a mise en place arrangement so precise and organized that it makes the chaos occurring inside the pot more bewildering, not less.

"The mise en place is beautiful," I say, from the barstool at the kitchen island where I am doing nothing helpful.

"Thank you. I spent twenty minutes on it."

"The mise en place is not the hard part."

"I know that now," he says, stirring something that is beginning to look concerning. "I knew that at the time, actually. I chose to believe in the mise en place."

Elena comes in, surveys the kitchen, kisses Sam on the cheek, opens the wine, pours three glasses, hands me one, takes one for herself, and sets Sam's on the counter where he can't reach it without stopping stirring.

"Okay," she says, sitting on the barstool beside me. "I have questions."

"Elena,"

"I've been polite for three weeks, Sam. You got three weeks of polite." She turns to face me with the full attention of someone who has earned the right to use it. "Where did you go to law school?"

"Columbia."

"What year did you graduate?"

"2016."

"Top of your class?"

"Third."

Elena considers this. "Why third?"

"I didn't sleep enough in Contracts first semester. I've thought about it a lot."

"Do you have opinions about things that Sam does?"

"Yes."

"Does he listen?"

"Occasionally."

"Better than his ex?"

"Elena,"

"I'm asking the important questions," Elena says, unperturbed. She steals a piece of prosciutto off my charcuterie plate , I brought charcuterie, because Sam's plan was risotto and I did not fully trust the plan , and eats it with the cheerful entitlement of someone who has decided we are already family. "His ex didn't have opinions. She had preferences. There's a difference. Opinions have reasons."

"My opinions have reasons," I confirm.

"What's your opinion about the risotto situation."

"It's over-stirred and the heat is too high and it's going to set up wrong."

Sam, without looking up: "I know."

"Then why,"

"Because I'm committed to the process and reversing course now feels like admitting defeat."

Elena looks at me. I look at Elena.

"He's been like this since he was nine," she says.

"I'm learning," I say.

Gerald is on the windowsill behind Elena, silhouetted against the April dark, looking at the kitchen situation with the fixed expression of a cactus that has seen things. I have been formally introduced to Gerald. The introduction went well, I think. He is three inches tall and entirely without mercy.

Sam's hand finds my shoulder blade when he leans past me to get to the salt , not reaching for me, just: passing through, contact made, contact not noted, continuing to the salt. He goes back to the risotto. Elena watches this with the expression of someone who has just confirmed a hypothesis she already had.

"Okay," she says, "I'm satisfied."

"That's it?"

"The salt thing," she says. She pours more wine.

---

Marco texts at 7:40: *i'm three blocks away. do you need food.* Sam texts back: *no we have risotto.* Marco texts: *i'm bringing food from sazon.* He shows up at 7:55 with a bag of takeout containers, surveys the risotto situation in approximately four seconds, sets the Sazon bag on the counter, and says, to no one in particular: "So this is what settling down looks like."

He sits on the green velvet couch and does not say anything else for forty minutes.

The risotto, for the record, is better than it should be. It sets up wrong, as predicted, but Sam adjusts, adds more stock, coaxes it into something that functions. Elena eats two plates. Marco adds it to the takeout containers like a man supplementing a meal he's already eaten. I eat mine with the specific attention I give to things that have outperformed their circumstances.

"The glaze shipped," Sam says, at some point during dinner. His feet are against my feet under the table, not intentional, just where they are. "The Seattle supplier got the modified compound out Thursday. Initial labs cleared it last week. It's done."

"Good," Elena says.

"There's already another problem," Sam says.

"What?"

"The applicator brush. Different issue. I'll tell you later."

Elena moves on. Sam moves on. I log it the way I log closed matters: noted, filed, next item.

Elena says: "Series A closed, by the way. March instead of April. Dev moved the timeline up."

I note the number, which Elena gives me because she assumes I want it, and I do: $4.2 million. I translate it automatically into what it means for Mobility Workshop's liability structure, their updated operating agreement, the amendments we filed in December. It is a clause in a document I've been tracking. It is also, I understand, a large number of things going right at once. I eat another bite of risotto.

---

Sam's phone rings at 8:30. He looks at it, looks at me, and answers with the slightly different posture of a person dealing with a known quantity.

"Mami." A pause, something said on the other end. "Yes, I'm at home. No, we're having dinner , Elena's here, and Marco." Pause. "And Berna, yes." Longer pause. "I don't , Mami." He stands up from the table, moves toward the kitchen, and I watch him from across the room. "She's great. She's , no, she's right here, I'm not going to , Mami, I'm not going to describe her like she's a listing." Elena is watching too. We exchange a look across the table that requires no annotation. "She's Berna," Sam says, into the phone, with the tone of someone who has located the correct word after a long search and found it was embarrassingly simple. "That's not , that's the whole , yes, okay. Yes. I'll tell her."

He comes back to the table. Sits down. His hand finds the back of my chair, then settles there without deciding to.

"My mother says welcome to the family."

"That's premature," I say.

"She knows that. She doesn't care."

Marco, from the couch: "She said that to me after two weeks and I've been around for six years."

"That's different," Sam says. "She actually likes Berna."

Marco puts down his fork. "That's unfair."

"It's accurate."

"It's still unfair."

---

Dev Chen is in the Mobility Workshop space on Wednesday , he wants to walk through the production area with the new operations coordinator, something about insurance riders and the updated liability matrix. Sam mentions this to me Tuesday night with the specific casualness of someone who is not managing me but is giving me information I can choose to use.

I choose to use it.

Dev Chen is shorter than I expected, which is relevant only because I had no mental image of him except his term sheets, which run long and favor subclauses. He sees me, recalibrates, and says: "Alvarez. I know your work."

"Dev Chen," I say. "I know yours."

He says: "The settlement restructuring , you put the mutual non-disclosure before the compensation clause."

"The compensation clause is more specific. Specifics should follow frameworks."

He considers this. "Risk-weighted approach."

"Document architecture. Same principle."

He looks at Sam, who is standing slightly to my left in the posture of a man prepared to explain something. He doesn't have to explain anything. He seems to realize this.

Dev says: "I was concerned about this situation. The conflict-of-interest exposure."

"Appropriately concerned," I say. "The exposure was real. It's been resolved through the appropriate channels, the file has been transferred, and all disclosures are current."

"I reviewed your disclosure form."

I wait.

"It was thorough," he says. This lands the way a favorable verdict lands , not dramatic, just: accurate, and therefore satisfying.

Dev shakes my hand, goes to find the operations coordinator, and disappears into the production area.

Sam says: "That was extremely positive, by the way."

"I know," I say.

He looks at me. "You knew."

"He said it was thorough. Dev Chen does not use positive modifiers unless the underlying assessment is favorable. It's in his term sheets , he only qualifies upward when he means it."

Sam stares at me for a moment. "You've read his term sheets."

"I reviewed the Series A documents."

"For what purpose?"

"To understand the structure I was working inside." I pause. "Also general interest."

He laughs , the surprised, quiet kind , and shakes his head, and we go find Dev Chen to look at insurance riders.

---

That night I am on the green velvet couch with my feet in Sam's lap and he is reading something, I don't know what, his thumb moving slowly across the page. The lamp is on. Gerald is on the windowsill. Marco has gone home. Elena has gone home. The takeout containers are in the recycling.

Sam turns a page. His hand rests on my ankle, not holding it, just: present.

I think about the disclosure form. The equity track, rescheduled to Q3. The Reyes matter. *Obviously.* The risotto that outperformed its circumstances. The way Dev Chen said *thorough* and meant it as the whole assessment. The way Sam said *she's Berna* into the phone like it was both an explanation and a complete sentence, and the thing was: it was.

I don't say any of this. It doesn't require saying.

He turns another page. His thumb on the paper, his hand on my ankle, the lamp making everything in the apartment the color of late evening in a place that is already familiar. Gerald stands on the windowsill without mercy or judgment.

Outside: the Hawthorne neighborhood in April. Somewhere a dog. Somewhere the MAX.

Inside: this.

$akm001ch19$,
  2375
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;

INSERT INTO public.fiamma_chapters (book_id, chapter_number, chapter_title, content_md, word_count)
VALUES (
  'akm-001-terms-and-conditions',
  20,
  'Chapter 20',
  $akm001ch20$
# Chapter 20

The argument about umbrellas began two blocks from Sam's apartment and had not resolved itself by the time we reached the river.

"I'm saying," Sam said, "that there's a philosophically correct answer, and the philosophically correct answer is that you bring the umbrella."

"You didn't bring the umbrella."

"Because I can't find it. That's a separate issue."

"You're making a philosophical argument for a tool you don't own."

"I own it. I just can't locate it. Gerald ate it, probably."

"Gerald is a cactus."

"Gerald," Sam said, "is a cactus with intentions."

The sky had been doing this all morning , that particular Portland May thing where it can't commit. Overcast but not actively raining. The kind of light that turns everything a specific shade of gray-green, like the city has been photographed with a filter it didn't ask for. It was sixty-one degrees. I had checked before we left because I check things.

Sam had not checked. Sam had put on a jacket that was in the approximate vicinity of appropriate for the weather and walked out into it without further research.

I have been building a taxonomy of this. The ways he moves through the world with a kind of provisional confidence , not recklessness, not carelessness, but a working assumption that the world will cooperate, and if it doesn't, he'll adjust. It is different from my approach, which is to determine in advance all ways the world might fail to cooperate and build redundancy into the plan. These are both reasonable methodologies. I am cataloguing the ways they intersect.

We turned toward the river. The Hawthorne Bridge was visible from here , that particular green of it, the steel truss framework catching the gray light, functional and unpretentious in the way Portland tends to be. You wouldn't call it beautiful in any dramatic sense. But it's there and it works, which is more than you can say for a lot of beautiful things.

---

"Okay," Sam said, "but what would you have done differently. If you'd been in charge of the bridge."

"I wasn't in charge of the bridge."

"Hypothetically."

"It was built in 1910. The engineers had different constraints."

"Sure, but you. Today. If you were designing a bridge over the Willamette."

I considered this with the seriousness it deserved, which was moderate. "I would probably have retained the through-truss structure. It's efficient. I might have reconsidered the draw span mechanism , the vertical lift design has had documented reliability issues over the years."

"You've researched the bridge."

"I looked it up when you said we should walk to it."

He stopped walking. Not dramatically , he just slowed and stopped, the way you do when something has genuinely delighted you and you need a moment to experience that. He was looking at me with an expression I've catalogued under several headings, none of them quite sufficient.

"What?" I said.

"Nothing. You looked up the bridge."

"I like to have context."

"I know," he said. "That's the thing."

We kept walking.

---

The draw span was raised for a boat when we got there , some kind of working vessel heading south, and the pedestrian signal had gone red, and we stood at the edge of the bridge approach with a small cluster of other people, waiting.

The rain started then. Not dramatically. Just the sky making a decision it had been putting off all morning , a light, purposeful rain, the kind that doesn't ask permission.

Around us, people made umbrella decisions. A man produced one from a bag. A woman pulled up her hood. Sam turned his face up for a moment, the way he does, and then looked at me with an expression that was somewhere between vindicated and apologetic.

"Philosophically correct," he said.

"The umbrella you can't find is not helping us."

"No," he agreed. "But I want credit for the underlying argument."

"Credit noted. Filed under theoretical frameworks with no practical application."

"That's most of philosophy."

"That's most of philosophy," I said, which was not a concession so much as an accurate statement.

The draw span came back down. The signal went green. We walked.

---

"I read the terms and conditions," I said.

He looked over at me. We were on the bridge now, the Willamette moving below us in that flat, pewter way it has in May , not beautiful, exactly, but honest. The kind of river that doesn't perform.

"All of them?" Sam said.

"I wrote several amendments."

He was quiet for a moment. Not the quiet of confusion , the quiet of someone receiving something and holding it correctly.

"Are the amendments binding?" he said finally.

"They're standard modifications. Reasonable adjustments to clauses that didn't account for specific circumstances." I paused. "The original terms were drafted without adequate information."

"And now you have adequate information."

"I have three months of data and a risotto sample size of seven. That's sufficient for a preliminary determination."

"Preliminary," he said.

"I'll issue the final assessment in the fullness of time."

He made the sound he makes when he's trying not to smile too widely. I've catalogued that too. It is not a difficult sound to recognize.

The rain was heavier now , not yet rain-rain, still the polite kind, but making its presence felt. My jacket was getting that damp-wool smell that is either pleasant or unpleasant depending on context. I was locating it, presently, in the pleasant column.

Sam said: "The version of the terms I got had a pretty significant gap in Section 4."

"What was in Section 4?"

"I think it was the part about mornings. And what happens when one party is functional before nine AM and the other isn't."

"That's a known asymmetry. It was addressed in Amendment Three."

"There's a Three?"

"There are six. I was thorough."

He laughed then , the laugh I heard before I saw his face, that first week, through the glass partition in the office that was not his office. It sounded the same. I don't know why I thought it would be different.

---

I thought, briefly and without drama, about the street outside The Wayward bar in November. The dark. The three inches of air between his fingers and my face. The decision he made not to cross them.

I had thought about it at the time in terms of restraint , his, mine, the situation's. The appropriate maintenance of professional distance, which was the accurate framing. I had not let myself think about it as loss, because loss would have required me to name what I wanted, and I was not prepared to file that paperwork yet.

The three inches had been the entire distance between what was and what was possible.

They seem, from here, very small.

I took his hand.

Not as a conclusion. Not as a statement. I just reached over and took it, the way you take something you've decided belongs to you , not urgently, not tentatively. His fingers were cold from the rain. So were mine. He adjusted his grip without looking over, without stopping, without making anything of it, and we kept walking.

The bridge continued. The rain continued. The Willamette moved below us with complete indifference to what was happening on the pedestrian path above it.

---

On the far side, there's a small covered area where the bridge meets the Hawthorne neighborhood , not a shelter, exactly, just an overhang where the structure extends. We stopped there without discussing it. The rain had graduated from polite to intentional, and standing in the narrow dry space, watching it fall on the bridge we'd just crossed, seemed like the reasonable thing to do.

Sam was looking out at the water. His hand was still in mine. There was nothing particular happening on his face , no performance of contentment, no documentation of the moment. He was just there.

"We need to find an umbrella," I said.

"We'll get one at the hardware store on Hawthorne. They have the good ones."

"You know the umbrella inventory of the hardware store on Hawthorne."

"I've bought umbrellas there before."

"How many umbrellas do you buy?"

"It's a process," he said. "I buy them and then Gerald hides them."

"Gerald is three inches tall."

"Gerald," Sam said, "has help."

I looked at our hands. The rain on the bridge. The gray-green light over the water, the same shade it had been all morning, patient about it.

This is what I know: I have read the relevant documentation. I have reviewed the terms, identified the gaps, drafted the modifications, circulated the amendments in my own good time. I have been thorough. Dev Chen would be, if not proud, then at least not surprised.

The three inches were always going to close. I just had to be the one to close them.

"Okay," I said. "Hardware store."

"Hardware store," he agreed. "And then maybe that café on 37th."

"What's on 37th."

"Good scones. You'll form opinions about them."

He was right. I would. I form opinions about everything, and I document them, and I file them in the appropriate place. That's what I do.

The rain came harder. I did not let go.

$akm001ch20$,
  1541
)
ON CONFLICT (book_id, chapter_number) DO UPDATE SET
  chapter_title = EXCLUDED.chapter_title,
  content_md = EXCLUDED.content_md,
  word_count = EXCLUDED.word_count;
