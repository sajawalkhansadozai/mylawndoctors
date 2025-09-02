import 'package:flutter/material.dart';
import 'package:lawndoctor/pages/plant_details_panel.dart';
import '../theme.dart';
import '../widgets.dart';

/* ------------------------------- MODEL ------------------------------- */

class Plant {
  final String id;
  final String name;
  final String price; // formatted PKR
  final String shortDesc; // ~2 lines
  final String longDesc; // detail paragraph
  final String coverImage; // thumbnail for card
  final List<String> images;

  const Plant({
    required this.id,
    required this.name,
    required this.price,
    required this.shortDesc,
    required this.longDesc,
    required this.coverImage,
    required this.images,
  });
}

/* --------------------------- 28-ITEM CATALOG -------------------------- */

const _catalog = <Plant>[
  Plant(
    id: 'rose-bush',
    name: 'Rose Bush (Hybrid Tea)',
    price: 'PKR 1,200',
    shortDesc:
        'Fragrant, classic blooms with long stems. Perfect for borders and cutting.',
    longDesc:
        'Bring home the show-stopping elegance of our Hybrid Tea Rose—Pakistan’s favorite cut-flower rose for a reason. Each long, straight stem carries a single, high-centered bloom that opens into classic, velvety petals perfect for vases, wedding décor, and statement borders. Planted in full sun (6–8 hours) and well-drained, compost-rich soil, Hybrid Teas reward you with repeat flushes from spring through late autumn; a light afternoon shade in extreme heat keeps colors intense and petals pristine. They’re surprisingly manageable: water deeply 1–2 times a week once established, mulch to lock in moisture, feed monthly during the growing season, and deadhead spent blooms to trigger the next wave. A simple late-winter prune (Jan–Feb) to 3–5 strong canes keeps plants vigorous and floriferous, while good airflow plus occasional neem/soap sprays help deter common pests and leaf spot. Whether you’re styling a terrace in Karachi, a courtyard in Lahore, or a garden bed in Islamabad, this rose delivers luxury on demand—sumptuous fragrance, florist-grade stems, and nonstop color that lifts every space. Add one as a focal point or group several for a designer hedge, then clip fresh blooms straight to your table. Ready to upgrade your garden and your home décor? Order your Hybrid Tea Rose today and enjoy bouquet-worthy flowers just steps from your door.',
    coverImage: 'assets/plants/rose1.jpg',
    images: [
      'assets/plants/rose1.jpg',
      'assets/plants/rose2.jpg',
      'assets/plants/rose3.jpg',
    ],
  ),
  Plant(
    id: 'areca-palm',
    name: 'Areca Palm',
    price: 'PKR 6,500',
    shortDesc:
        'Lush, feathery fronds. Brings tropical vibes indoors or on patios.',
    longDesc:
        'Elevate your space instantly with the Areca Palm (Dypsis lutescens)—the lush, feathery “golden cane” that delivers resort vibes to apartments, offices, and patios across Pakistan. A graceful clumping palm with multiple bamboo-like canes and elegant arching fronds, Areca thrives in bright, indirect light indoors (near a window with filtered sun) and in bright shade outdoors; protect it from harsh midday rays in Karachi/Lahore summers to keep leaf tips pristine. Give it a fast-draining mix (potting soil + perlite/coarse sand), water when the top 2–3 cm feel dry, and never leave the roots standing in saucers; consistent, moderate moisture is key. From spring through monsoon, feed monthly with a balanced, palm-safe fertilizer, then reduce in winter; repot every 2–3 years into a 10–14″ pot as clumps expand. Brown tips usually signal low humidity or salts—mist occasionally, wipe fronds to shine, and flush the soil every few months. Naturally non-toxic to cats and dogs and widely praised for air-freshening foliage, Areca Palms grow quickly to 5–8 ft indoors (taller in courtyards), creating soft privacy screens for balconies and a designer focal point for living rooms, lobbies, and cafés. Pest-wise they’re easy: check for spider mites/mealybugs and treat early with neem. Want a polished, tropical look with minimal fuss and maximum impact? Choose the Areca Palm—our most popular indoor palm—and enjoy a breezy, boutique-hotel feel every day.',
    coverImage: 'assets/plants/areca1.jpg',
    images: [
      'assets/plants/areca1.jpg',
      'assets/plants/areca2.jpg',
      'assets/plants/areca3.jpg',
    ],
  ),
  Plant(
    id: 'ficus-benjamina',
    name: 'Ficus Benjamina (Weeping Fig)',
    price: 'PKR 5,000',
    shortDesc: 'Elegant, glossy foliage. A timeless indoor statement tree.',
    longDesc:
        'Bring timeless elegance to your home or office with Ficus benjamina (Weeping Fig)—the designer-favorite statement tree that instantly adds height, texture, and a calm, upscale vibe. Its slender, braided-ready trunk and dense, glossy canopy look stunning in living rooms, foyers, cafés, and reception areas across Pakistan. Give it bright, indirect light (a few hours of filtered sun near an east or bright south window) and a fast-draining mix; water when the top 2–3 cm of soil are dry, then let excess drain—consistent, not soggy. Feed monthly in spring through monsoon with a balanced fertilizer, pause in winter, and rotate the pot periodically for even shape. Expect some leaf drop after moving or seasonal changes—totally normal; reduce drafts, avoid overwatering, and it rebounds quickly. Prune lightly in late winter to maintain a crisp silhouette or to encourage a lush, umbrella form; wipe leaves to keep that luxurious sheen. Watch for scale or mealybugs and treat early with neem or insecticidal soap. Mature indoor plants reach 5–8 ft, creating natural privacy and a premium “hotel-lobby” finish without the maintenance headaches of more delicate species. (Note: sap can irritate sensitive skin; keep out of reach of curious pets.) Want a sophisticated, evergreen focal point that reads “tasteful” from every angle? Choose Weeping Fig and elevate your space—beautifully and effortlessly.',
    coverImage: 'assets/plants/ficus1.jpg',
    images: [
      'assets/plants/ficus1.jpg',
      'assets/plants/ficus2.jpg',
      'assets/plants/ficus3.jpg',
    ],
  ),
  Plant(
    id: 'lavender',
    name: 'Lavender (English)',
    price: 'PKR 900',
    shortDesc:
        'Aromatic purple spikes; pollinator magnet. Loves sun, hates wet feet.',
    longDesc:
        'Turn any sunny corner into a spa-scented showpiece with English Lavender (Lavandula angustifolia)—the low-maintenance, high-impact classic that delivers silvery foliage, violet flower spikes, and a soothing fragrance all season. Perfect for borders, pathways, patios, and rooftops, it forms neat mounds (about 30–60 cm tall and 45–60 cm wide) that look designer-clean even when not in bloom. Give it full sun and excellent drainage (gritty/sandy mix; raised beds or pots are ideal), water deeply but infrequently once established, and avoid “wet feet.” In Pakistan’s warmer zones, choose the sunniest, breeziest spot for good airflow; in cooler areas it thrives with ease and even tolerates light frost. Trim lightly after the first flush to keep a compact shape and encourage repeat flowering, then give a harder prune at the end of winter to refresh growth. Lavender’s nectar-rich blooms attract bees and butterflies, while its natural oils help deter common pests—so your garden stays lively and low-fuss. Cut stems for long-lasting bouquets, dry them for sachets and wreaths, or infuse teas and bakes with culinary varieties. Pair it with roses, ornamental grasses, and stone edging for that timeless Mediterranean look. Want effortless elegance, fragrance, and pollinator power in one plant? Choose English Lavender and upgrade your space—beautifully, sustainably, and year after year.',

    coverImage: 'assets/plants/lav1.jpg',
    images: [
      'assets/plants/lav1.jpg',
      'assets/plants/lav2.jpg',
      'assets/plants/lav3.jpg',
    ],
  ),
  Plant(
    id: 'snake-plant',
    name: 'Snake Plant (Sansevieria)',
    price: 'PKR 1,800',
    shortDesc: 'Ultra-tough, architectural leaves. Thrives on neglect.',
    longDesc:
        'Built for busy homes and modern offices, the Snake Plant (Sansevieria)—also known as Dracaena trifasciata—delivers designer looks with near-indestructible toughness, making it the ultimate “set-and-forget” statement plant you’ll actually keep alive. Its upright, sculptural leaves (usually 30–90 cm tall, taller in floor pots) bring clean architectural lines to hallways, lounges, bedrooms, and reception areas, while variegated patterns (from classic ‘Laurentii’ with golden edges to cool-toned ‘Moonshine’ and deep green ‘Zeylanica’) complement every interior. It tolerates low to bright, indirect light (even fluorescent offices), thrives on infrequent watering (let soil dry completely between drinks—every 2–4 weeks depending on season), and prefers a fast-draining mix (cactus/succulent blend with added perlite). Warm rooms are ideal (18–30 °C); it shrugs off dry air and occasional neglect, and you’ll rarely see pests. Styling is effortless: use tall cylinders for a minimalist look, cluster three sizes for a layered vignette, or line a corridor with matching planters for a boutique-hotel vibe. Maintenance is minimal—wipe leaves monthly to restore their shine, rotate the pot for even growth, and feed lightly in spring/summer. Want more plants for free? Divide clumps when repotting or propagate leaf cuttings. With a reputation for freshening up the feel of indoor air and a proven track record as the hardiest houseplant on the market, the Snake Plant is an easy upsell for landlords, cafés, studios, and busy families alike—low water, low drama, maximum style.',
    coverImage: 'assets/plants/snake1.jpg',
    images: [
      'assets/plants/snake1.jpg',
      'assets/plants/snake2.jpg',
      'assets/plants/snake3.jpg',
    ],
  ),
  Plant(
    id: 'bougainvillea',
    name: 'Bougainvillea',
    price: 'PKR 3,200',
    shortDesc:
        'Explosive color; thrives in heat and full sun. Great for trellises.',
    longDesc:
        'Turn any wall, gate, or rooftop into a tropical postcard with Bougainvillea—the sun-loving color machine that thrives in Pakistan’s heat and rewards you with cascades of magenta, fuchsia, orange, red, or snow-white bracts for months on end. Give it 6–8 hours of direct sun, a sturdy support (trellis, pergola, boundary wall, balcony railing), and very free-draining soil, and it will repay you with explosive bloom cycles and minimal upkeep; water deeply but infrequently (let the topsoil dry well), keep fertilizer modest and slightly higher in phosphorus (too much nitrogen = leaves, not flowers), and prune lightly right after each flush to shape and trigger new color. Whether you plant it in the ground (it can easily reach 2–5 m when trained) or keep it in a 14–20" container for patios and terraces, Bougainvillea loves the long, hot summers of Karachi, Lahore, and Multan, and it also performs beautifully in Islamabad and Peshawar with a little winter protection—simply shelter containers under an eave during cold snaps and avoid soggy soil. Thorny stems add a natural privacy and security edge, while drought tolerance makes it a smart, water-wise choice for sunny facades and rooftop gardens. Looking to wow your guests or pull attention to an entrance? Train it as an arch over your driveway; want balcony drama without the maintenance? Choose a compact variety and let it trail over the railing. For property managers, cafés, and homeowners alike, Bougainvillea is the ultimate high-impact, low-maintenance upgrade—bold color, fast coverage, and a premium look that sells your space from the street.',
    coverImage: 'assets/plants/boug1.jpg',
    images: [
      'assets/plants/boug1.jpg',
      'assets/plants/boug2.jpg',
      'assets/plants/boug3.jpg',
    ],
  ),
  Plant(
    id: 'hibiscus',
    name: 'Hibiscus (Tropical)',
    price: 'PKR 2,400',
    shortDesc: 'Large, dramatic flowers. Continuous color in warm seasons.',
    longDesc:
        'Make every day feel like a tropical holiday with Hibiscus (Hibiscus rosa-sinensis)—the show-stopping shrub that delivers plate-size flowers in blazing reds, corals, yellows, pinks, and whites almost year-round in Pakistan’s warm climates. Give it 5–7 hours of direct sun (light afternoon shade in peak Karachi/Lahore heat is welcome), rich well-drained soil, and steady moisture (never swampy), and it will reward you with a fresh bloom nearly every morning—each flower lasts a day, but the plant keeps producing nonstop when fed and watered right. In pots (14–18" with large drainage holes) or in-ground beds, mix compost with a bit of sand for drainage and feed every 2–3 weeks during the growing season with a potassium-forward fertilizer (too much nitrogen means leaves instead of blooms). Pinch or lightly prune after a flush to keep it bushy, remove spent flowers to tidy, and watch it bounce back fast. It thrives outdoors across Karachi, Hyderabad, Multan, and coastal belts; in Islamabad/Rawalpindi or other cooler zones, protect from cold snaps below ~10 °C, reduce watering in winter, and keep soils just moist. If pests like aphids, whitefly, or mealybugs show up, a quick rinse plus a neem-oil spray sorts them out without harsh chemicals. Use Hibiscus as statement pairings at your entrance, poolside accents with palms, a color-rich hedge along a boundary, or as a single specimen trained into a standard for instant “resort” vibes. Few plants deliver this much color per rupee with such reliable performance—Hibiscus is the effortless, high-impact upgrade that makes homes, cafés, and storefronts look premium at a glance.',
    coverImage: 'assets/plants/hib1.jpg',
    images: [
      'assets/plants/hib1.jpg',
      'assets/plants/hib2.jpg',
      'assets/plants/hib3.jpg',
    ],
  ),
  Plant(
    id: 'jasmine',
    name: 'Jasmine (Arabian)',
    price: 'PKR 1,600',
    shortDesc: 'Intensely fragrant white flowers; evening scent is magical.',
    longDesc:
        'Turn every evening into a calm, perfume-filled oasis with Arabian Jasmine (Jasminum sambac)—the classic, intensely fragrant climber behind Pakistan’s beloved gajras and entrance garlands, now ready to elevate your home, café, or boutique with effortless elegance. This compact, glossy-leafed vine loves warmth and bright light: give it 5–6 hours of sun (light afternoon shade in peak Lahore/Karachi heat is fine), plant in well-drained, compost-rich soil, and water deeply when the top inch dries—never soggy, never bone-dry. In pots (12–16" with big drainage holes) or ground, feed every 3–4 weeks during the growing season with a bloom-boosting fertilizer to keep buds coming; prune lightly after a flush to shape and encourage branching, and let it twine up a trellis, balcony rail, or arch for a romantic, boutique-hotel look. In Islamabad/Rawalpindi, protect from cold snaps below ~8–10 °C and reduce watering in winter; in coastal or southern climates, it flowers almost year-round. If aphids or whiteflies appear, a simple rinse plus neem-oil spray keeps foliage pristine without harsh chemicals. Use it as a scented entry statement, a privacy screen that greets guests at dusk, or a container feature near outdoor seating where its evening fragrance truly shines. Few plants deliver this level of luxury per rupee—Arabian Jasmine is your fast track to a refined, welcoming space that smells unforgettable; add it to your garden today and let the compliments roll in.',
    coverImage: 'assets/plants/jas1.jpg',
    images: [
      'assets/plants/jas1.jpg',
      'assets/plants/jas2.jpg',
      'assets/plants/jas3.jpg',
    ],
  ),
  Plant(
    id: 'marigold',
    name: 'Marigold',
    price: 'PKR 250',
    shortDesc: 'Bright, cheerful bedding plant; easy and reliable.',
    longDesc:
        'Brighten your garden instantly and affordably with Marigolds (Tagetes)—Pakistan’s most reliable, high-impact seasonal color for borders, pots, pathways, and festive décor. Available in rich golds, yellows, oranges, and bicolors, French types (Tagetes patula) stay compact and bushy for edging, while African types (Tagetes erecta) deliver big, showy blooms for statement beds and event garlands. They thrive in full sun (aim for 6–8 hours; offer light afternoon shade in peak Sindh heat), prefer well-drained soil, and reward you with nonstop flowers if you water deeply when the top inch dries and deadhead spent blooms weekly. For bushier plants with more buds, pinch young tips at 4–6 leaves; feed every 2–3 weeks with a balanced, low-nitrogen fertilizer so energy goes to flowers, not just foliage. Sow seeds in late summer to early autumn for the classic winter display in Punjab/KPK/Islamabad, or start in early spring for extended color in milder/coastal areas; transplant once seedlings have 3–4 true leaves, spacing 20–30 cm for French and 30–45 cm for African varieties. Naturally helpful in kitchen gardens, marigolds are known to discourage certain pests and nematodes—plant them near tomatoes, chilies, and okra as cheerful “bodyguards.” Keep foliage clean, and if aphids or spider mites appear, a firm water spray plus neem oil usually restores perfection fast. Tough, fast-blooming, and unbelievably cost-effective per square foot, marigolds deliver that “festival look” with near-zero fuss—add a tray today, and watch your space go from ordinary to celebratory in a single weekend.',
    coverImage: 'assets/plants/mar1.jpg',
    images: [
      'assets/plants/mar1.jpg',
      'assets/plants/mar2.jpg',
      'assets/plants/mar3.jpg',
    ],
  ),
  Plant(
    id: 'petunia',
    name: 'Petunia',
    price: 'PKR 300',
    shortDesc: 'Cascade of color for beds, baskets, and planters.',
    longDesc:
        'Create instant, high-impact color with Petunias—the undisputed stars of borders, planters, window boxes, and hanging baskets—delivering cascades of blooms in dazzling pinks, purples, whites, reds, and striking bicolors all season long. In Pakistan’s plains, petunias shine as cool-season performers: plant from September–November for a luxurious winter-spring display (great in Karachi, Lahore, Islamabad, Peshawar), and refresh in early spring if late heat arrives; in cooler hill stations, they’ll flower even longer. Give them 6+ hours of sun, excellent drainage, and a light, airy potting mix (add perlite or coco peat), then water deeply when the top 2–3 cm dry—avoid soggy roots and overhead splashing to prevent botrytis. Feed every 7–10 days with a balanced or bloom-boost fertilizer (or use a slow-release base plus a weekly liquid top-up), pinch young tips at 6–8 leaves for bushy plants, and shear back by one-third mid-season to trigger a fresh flush of buds. Choose Grandiflora for big, dramatic flowers in sheltered spots, Multiflora for wind/heat tolerance and masses of smaller blooms, and Trailing/“Wave”/Surfinia types for that premium waterfall effect in baskets and rail planters. Space 25–35 cm apart, deadhead where needed (many modern types are self-cleaning), and keep an eye out for aphids/whitefly—neem oil or a strong water spray usually sets things right. The result? A low-maintenance, high-value carpet of color that transforms entrances and patios into boutique-garden showpieces. Order a mixed tray today—we’ll plant, feed, and style them for you so your space looks professionally finished within hours.',
    coverImage: 'assets/plants/pet1.jpg',
    images: [
      'assets/plants/pet1.jpg',
      'assets/plants/pet2.jpg',
      'assets/plants/pet3.jpg',
    ],
  ),
  Plant(
    id: 'aloe-vera',
    name: 'Aloe Vera',
    price: 'PKR 950',
    shortDesc: 'Succulent with useful gel; low-water hero.',
    longDesc:
        'Bring home the desert superstar with Aloe Vera—a sculptural, low-maintenance succulent that earns its keep with striking form and everyday usefulness. Thick, blue-green leaves store water so the plant thrives on neglect: give it bright light (full sun to bright, indirect), a free-draining cactus mix (add coarse sand/perlite), and water only when the soil is bone dry 5–8 cm down—typically every 10–21 days depending on season; overwatering is the only real way to lose it. Ideal temperatures are 20–35 °C; protect from cold snaps below ~8–10 °C and harsh winter drafts. In Pakistan’s plains, keep it outdoors in morning sun and dappled afternoon light; in peak summer heat, shift to bright shade to prevent leaf scorch. Indoors, park it by an east or west window and rotate monthly for a balanced rosette. Feed very lightly in spring (¼-strength succulent fertilizer) and skip winter feedings. Aloe offsets (“pups”) appear around the base—separate and pot them for instant new plants or a fuller bowl display. Common issues like soft, collapsing leaves signal excess water; blotchy pale growth points to too little light—both easy fixes. Beyond looks, the leaf gel is widely used to soothe minor skin discomforts—another reason it’s a household essential.* We supply chunky, well-rooted plants in 6–8″ pots and premium specimen rosettes ready for reception corners, balconies, and kitchen windows. Want it styled? Choose our terracotta or matte ceramic potting upgrade and we’ll deliver, plant, top-dress with decorative gravel, and position it for perfect light—so you get that clean, modern “designer” finish from day one. Not a medical product; for serious concerns, consult a professional.',
    coverImage: 'assets/plants/aloe1.jpg',
    images: [
      'assets/plants/aloe1.jpg',
      'assets/plants/aloe2.jpg',
      'assets/plants/aloe3.jpg',
    ],
  ),
  Plant(
    id: 'money-plant',
    name: 'Money Plant (Pothos)',
    price: 'PKR 700',
    shortDesc: 'Fast-growing indoor vine; forgiving and stylish.',
    longDesc:
        'Meet the Money Plant (Pothos/Devil’s Ivy)—the ultimate “set-and-forget” indoor vine that brings instant freshness, lush texture, and effortless style to homes, offices, cafés, and balconies. Famous for its heart-shaped, variegated leaves and fast growth, Pothos tolerates a wide range of conditions in Pakistan: it thrives in bright, indirect light but also copes with medium to low light (avoid harsh, direct afternoon sun), and it’s wonderfully forgiving if you occasionally forget to water. Give it a drink only when the top 2–3 cm of soil feel dry; overwatering (yellowing leaves, soggy soil) is the only real mistake to avoid. Expect vigorous trailing stems perfect for shelves and hanging planters—or train it upright on a moss pole for a fuller, leafy column; pinch tips to keep it dense and bushy, and watch new shoots explode. Variegation will be boldest in brighter light; if leaves turn more solid green, simply move it closer to a window. Normal indoor temperatures (18–32 °C) and average humidity are ideal, pests are rare, and propagation is a joy—snip a cutting with a node, root it in water, and you’ve got an instant gift or a thicker mother plant. We supply premium, well-rooted Pothos in multiple formats—6–8″ trailing pots, lush hanging baskets, and 10–12″ totem styles—plus a choice of matte ceramic or terracotta planters; opt for our “Styled & Delivered” service and we’ll pot, top-dress with decorative gravel, and place it for perfect light with a simple care card. Want a fast, low-maintenance green upgrade that looks expensive and grows with you? Money Plant is your best value—reliable, beautiful, and ready to transform your space from day one.',
    coverImage: 'assets/plants/pothos1.jpg',
    images: [
      'assets/plants/pothos1.jpg',
      'assets/plants/pothos2.jpg',
      'assets/plants/pothos3.jpg',
    ],
  ),
  Plant(
    id: 'bamboo-palm',
    name: 'Bamboo Palm',
    price: 'PKR 5,800',
    shortDesc: 'Fine-textured palm for airy, elegant screening.',
    longDesc:
        'Meet the Bamboo Palm (Chamaedorea seifrizii)—an elegant, fine-textured clumping palm that instantly softens corners, divides spaces, and brings cool, tropical calm to homes, offices, and lobbies across Pakistan. With its slender “bamboo-like” canes and airy fronds, it thrives in bright, indirect to medium light (tolerates lower light better than most palms), and prefers evenly moist—but never soggy—soil; water when the top 2–3 cm are dry, and avoid harsh afternoon sun that can scorch leaf tips. Comfortable in normal indoor temperatures (18–32 °C) and average humidity, Bamboo Palm is slow to moderate in growth, reaching 1.2–2 m indoors (taller in shady outdoor courtyards), is generally considered non-toxic to pets, and is praised for freshening air while adding a refined, resort-style vibe year-round. For best results, use a well-draining peat/bark mix, feed lightly at half-strength during spring–summer, wipe fronds to keep them glossy, and repot every 2–3 years as clumps expand; if tips brown, ease up on salts and switch to filtered water. We supply premium, multi-stemmed specimens in 10–14″ growers’ pots, statement 16–18″ floor sizes, and styled options in matte ceramic or classic terracotta; choose our “Styled & Delivered” package and we’ll pot, top-dress, place for ideal light, and leave a simple care card—plus optional maintenance visits to keep it picture-perfect. Want a lush, low-maintenance focal point that looks expensive without demanding attention? Bamboo Palm is your quietly luxurious upgrade—calm, clean, and ready to elevate your space from day one.',
    coverImage: 'assets/plants/bamboo1.jpg',
    images: [
      'assets/plants/bamboo1.jpg',
      'assets/plants/bamboo2.jpg',
      'assets/plants/bamboo3.jpg',
    ],
  ),
  Plant(
    id: 'rubber-plant',
    name: 'Rubber Plant (Ficus elastica)',
    price: 'PKR 4,200',
    shortDesc: 'Bold, glossy leaves; modern indoor statement.',
    longDesc:
        'Meet the Rubber Plant (Ficus elastica)—a bold, sculptural statement tree with glossy, oversized leaves that instantly make any room feel more modern, curated, and alive. Tough and forgiving, it thrives in bright, indirect light (morning sun is great; harsh afternoon rays can scorch), but it also tolerates medium light better than most “designer” plants; water when the top 3–5 cm of soil are dry and keep the mix well-draining to avoid soggy roots. Expect slow-to-moderate growth to 1.5–2.5 m indoors (prune the tip to maintain a compact, bushier silhouette), wipe leaves monthly to keep that luxurious shine, and turn the pot every few weeks for even, photo-worthy symmetry. Perfectly at home in Pakistan’s indoor climates (18–32 °C), the Rubber Plant adapts to AC and low humidity, and rewards minimal care with year-round, high-impact greenery—choose classic deep green ‘Robusta’ for a rich, architectural look or variegated ‘Tineke’/‘Ruby’ for designer cream-and-blush tones that pop against neutral walls. We supply premium, straight-cane or multi-branched forms in 8–14″ growers’ pots and statement 16–18″ floor sizes, plus styled options in matte ceramic or terracotta; add our “Styled & Delivered” package for professional potting, decorative top-dress, perfect placement, and a simple care card, or opt into ongoing maintenance so it always looks showroom-fresh. If you want an effortlessly upscale focal point that photographs beautifully, purifies the vibe of your space, and keeps its good looks with minimal fuss, the Rubber Plant is your best-selling upgrade—quiet luxury, delivered.',
    coverImage: 'assets/plants/rubber1.jpg',
    images: [
      'assets/plants/rubber1.jpg',
      'assets/plants/rubber2.jpg',
      'assets/plants/rubber3.jpg',
    ],
  ),
  Plant(
    id: 'dracaena',
    name: 'Dracaena (Song of India)',
    price: 'PKR 3,100',
    shortDesc: 'Striped, architectural foliage; easy-care indoor.',
    longDesc:
        'Meet Dracaena (Song of India)—Dracaena reflexa with luminous lime-and-cream variegation that instantly brightens corners and adds boutique-hotel polish to homes and offices alike; its naturally tiered, architectural canes create a sculptural silhouette that looks “designed” even when you’ve done almost nothing. Happy in Pakistan’s indoor conditions (18–32 °C), it thrives in bright, indirect light but stays handsome in medium light too; outdoors, give it dappled shade on verandas/patios and protect from harsh afternoon sun and cold snaps. Watering is delightfully simple: let the top 2–4 cm of soil dry, then water thoroughly—this plant prefers a free-draining mix and absolutely hates sitting in soggy pots (hello, root rot), so choose a container with drainage and go easy in winter. Growth is slow to moderate to 1–2 m indoors; tip-prune to keep that layered, bushy form or to encourage fresh, variegated shoots, and wipe leaves monthly to keep the stripes glowing. Want more plants for free? It propagates from stem cuttings in warm weather, rooting readily in water or a light mix. Stylistically, Song of India is a chameleon—pair with matte white, charcoal, or natural rattan planters; use single-cane for a sleek, minimal look or multi-cane clusters for lush impact beside sofas, reception desks, and entryways. We supply premium, straight or multi-brached specimens in 8–14″ growers’ pots and designer ceramic or terracotta upgrades, plus our “Styled & Delivered” service (professional potting, decorative top-dress, perfect placement, and a simple care card) with optional maintenance so it stays showroom-fresh. If you’re after a low-effort, high-wow statement that cleans up the look of any room and photographs beautifully, Dracaena Song of India is the bright, modern upgrade your space has been waiting for.',
    coverImage: 'assets/plants/drac1.jpg',
    images: [
      'assets/plants/drac1.jpg',
      'assets/plants/drac2.jpg',
      'assets/plants/drac3.jpg',
    ],
  ),
  Plant(
    id: 'gardenia',
    name: 'Gardenia',
    price: 'PKR 2,800',
    shortDesc: 'Luxurious scent and glossy evergreen leaves.',
    longDesc:
        'Discover Gardenia—the timeless white-rose of the tropics—celebrated for its intoxicating perfume and glossy, deep-green leaves that make any doorway, patio, or living room feel instantly luxurious; few plants deliver this level of fragrance and elegance with such compact poise. For best performance in Pakistan, give bright light with gentle morning sun and dappled afternoon shade (east or southeast exposure is ideal), keep temperatures between 18–28 °C, and maintain consistent moisture without waterlogging in a fast-draining, slightly acidic mix (think peat/coir + perlite + pine bark); feed lightly during spring–summer with an acid-loving fertilizer and use iron chelate if leaves yellow between veins. Bud drop comes from stress—avoid cold drafts, heat blasts, or letting the root ball swing from bone-dry to soaked; a humidity tray or weekly foliage mist (morning only) keeps blooms coming. Expect flushes from late spring into summer, with varieties like ‘August Beauty’ or ‘Veitchii’ rewarding you with repeat flowers perfect for bridal-scent arrangements. As a premium accent, Gardenia shines in ceramic planters by entrances, on café tables, or in reception areas, pairing beautifully with boxwood lines and soft uplighting. We offer nursery-grade, bud-set specimens, designer pot upgrades, and our optional “Styled & Delivered” service—professional potting, decorative top-dress, placement, and a simple care card—so you enjoy that head-turning fragrance and five-star finish from day one.',
    coverImage: 'assets/plants/gard1.jpg',
    images: [
      'assets/plants/gard1.jpg',
      'assets/plants/gard2.jpg',
      'assets/plants/gard3.jpg',
    ],
  ),
  Plant(
    id: 'camellia',
    name: 'Camellia',
    price: 'PKR 4,900',
    shortDesc: 'Winter/early-spring blooms; glossy evergreen.',
    longDesc:
        'Meet Camellia—the queen of cool-season color—delivering lush, rose-like blooms precisely when most gardens are quiet, from late autumn through early spring; whether you choose classic Japonica for large, formal doubles or tough, early-blooming Sasanqua for lighter, airy flowers, you’ll get an elegant, evergreen screen with glossy leaves and a premium, estate look at your door or entry court. Camellias thrive with bright, indirect light or gentle morning sun and afternoon shade (east/north exposures are ideal), in a free-draining, slightly acidic mix (pH 5.5–6.5); think peat/coir + pine bark + perlite with a 5–7 cm mulch of pine needles or bark to keep roots cool. Water deeply but infrequently—never soggy—and feed lightly with an acid-loving fertilizer after bloom; prune immediately post-flowering to shape (next season’s buds set early). In hotter Pakistani plains, container culture under verandas or filtered shade keeps Camellias happy; in cooler hill stations they shine even in brighter spots. Expect reliable buds when temperature swings are moderate and roots stay evenly moist; protect open blooms from harsh, hot winds and severe frost snaps. We supply nursery-grade Camellias in curated colours (white, blush, rose, crimson, and variegated), plus optional “Styled & Delivered” setup: premium potting in our acid mix, decorative top-dress, placement plan, and a simple care card—so you enjoy a winter showpiece, photo-ready hedges, and long-lived elegance with zero guesswork.',
    coverImage: 'assets/plants/cam1.jpg',
    images: [
      'assets/plants/cam1.jpg',
      'assets/plants/cam2.jpg',
      'assets/plants/cam3.jpg',
    ],
  ),
  Plant(
    id: 'hydrangea',
    name: 'Hydrangea (Macrophylla)',
    price: 'PKR 3,700',
    shortDesc: 'Huge mophead flowers; show-stopping borders.',
    longDesc:
        'Turn shady corners into showstoppers with Hydrangea macrophylla—the famous mophead and lacecap hydrangea that delivers cloud-like blooms from late spring through summer and looks luxurious in beds, borders, and big pots; give it bright morning sun with afternoon shade (or dappled light all day in hotter areas), rich moisture-retentive but free-draining soil, and a thick bark mulch to keep roots cool and flowers lasting. Color is customizable: for blue blooms target slightly acidic pH ~5.0–5.5 and add aluminum sulfate; for pink aim for pH ~6.0–6.5 with a touch of garden lime—test, adjust slowly, and feed lightly with a balanced, slow-release fertilizer in early spring and again mid-summer. Keep soil evenly moist (never waterlogged), deadhead spent clusters, and remember most macrophyllas bloom on old wood—so skip hard pruning; after flowering, remove only dead or crossing stems and let next year’s buds set. In the Pakistani plains, containers under verandas or east-facing beds keep foliage fresh through hot spells; in cooler hill stations they’ll tolerate more light. We offer curated mophead and lacecap selections in blues, pinks, whites, and bicolors, plus our “Styled & Delivered” upgrade: premium potting mix, pH/color setup, decorative top-dress, placement plan, and a simple care card—so you enjoy florist-grade hydrangeas at home, abundant blooms for the vase, and a garden that photographs like a resort.',
    coverImage: 'assets/plants/hyd1.jpg',
    images: [
      'assets/plants/hyd1.jpg',
      'assets/plants/hyd2.jpg',
      'assets/plants/hyd3.jpg',
    ],
  ),
  Plant(
    id: 'azalea',
    name: 'Azalea',
    price: 'PKR 2,200',
    shortDesc: 'Spring color clouds; compact evergreen mounds.',
    longDesc:
        'Bring spring to life with Azaleas—compact, glossy evergreens that explode into clouds of pinks, reds, corals, and whites, turning beds, borders, and entry pots into instant showpieces; they thrive in dappled shade (morning sun, afternoon protection) and prefer acidic, free-draining soil (target pH 4.8–5.8 with pine bark/peat and perlite), steady moisture without waterlogging, and a cool root zone under pine-needle or bark mulch; in hotter Pakistani plains, tuck them under verandas or light tree canopies, while in cooler hill stations they’ll take more light; feed lightly with an ericaceous fertilizer after bloom, water with low-alkalinity (or rain) water where possible, and prune immediately after flowering—just a light shape—so next year’s buds aren’t cut off; deadhead spent trusses for a tidy, continuous display; they pair beautifully with hydrangeas, camellias, and ferns for a layered, high-end look; choose from our curated Indica and Kurume selections (compact to medium heights) and ask about our “Styled & Delivered” Azalea Setup: soil acidification, mulch dressing, irrigation plan, and a simple seasonal care card; order today and we’ll position your azaleas for maximum color with minimal fuss—so every spring your garden pops like a luxury resort, your entryway feels premium, and your guests ask, “Who designed this?”',
    coverImage: 'assets/plants/aza1.jpg',
    images: [
      'assets/plants/aza1.jpg',
      'assets/plants/aza2.jpg',
      'assets/plants/aza3.jpg',
    ],
  ),
  Plant(
    id: 'ixora',
    name: 'Ixora',
    price: 'PKR 1,850',
    shortDesc: 'Clusters of bright florets; thrives in heat.',
    longDesc:
        'Turn up the tropical color with Ixora—compact, glossy-leaved shrubs that produce dense clusters of blooms in vivid reds, oranges, yellows, and pinks almost year-round; they love warmth and bright light (aim for 5–7 hours of sun, with light afternoon shade in the hottest months), thrive in slightly acidic, free-draining soil (pH ~5.0–6.0—mix in peat/pine bark and perlite), and want consistent moisture without waterlogging; feed monthly in the growing season with an acid-loving fertilizer plus iron/micronutrients to prevent leaf yellowing (chlorosis), and lightly prune after flushes of bloom to keep them bushy and flower-heavy; perfect as low hedges along paths and driveways, anchor plants in mixed borders, or statement pots for terraces in Karachi and other warm cities (treat as a patio container in cooler zones and protect from cold snaps); pair with hibiscus, areca palms, and variegated dracaena for a resort-style palette, add 5–7 cm of organic mulch to cool roots and hold moisture, and watch for mealybugs/scale—both easily managed with neem or horticultural soap; choose from our curated dwarf and medium varieties for tight spaces or bold hedging, and let our Styled & Delivered Ixora Package handle the soil acidification, planting, drip setup, and a simple care card; order today and we’ll position your Ixora for uninterrupted color, so your entrance pops, your borders glow, and your landscape looks five-star with nearly zero fuss.',
    coverImage: 'assets/plants/ixo1.jpg',
    images: [
      'assets/plants/ixo1.jpg',
      'assets/plants/ixo2.jpg',
      'assets/plants/ixo3.jpg',
    ],
  ),
  Plant(
    id: 'neem',
    name: 'Neem Tree (Azadirachta indica)',
    price: 'PKR 2,900',
    shortDesc: 'Hardy shade tree with traditional value.',
    longDesc:
        'Bring home a living guardian with the Neem Tree (Azadirachta indica)—a tough, evergreen shade-maker that thrives in Pakistan’s heat and coastal breezes while naturally discouraging many garden pests; native to the subcontinent and celebrated for its resilient wood and aromatic foliage, neem forms a graceful, airy canopy that cools courtyards, parking areas, and farmhouses with minimal care; give it full sun (6–8+ hours), well-drained soil (sandy loam or any non-waterlogged ground), and deep, infrequent watering in the first year to build roots—after establishment it’s impressively drought-tolerant; plant 5–7 m from walls and lines to respect its mature spread, stake young trees against wind, and prune lightly once a year to raise the canopy and keep a clean structure; tiny white flowers appear in warm months (pollinator friendly), fruit feeds birds, and the leaves/seed contain azadirachtin—a natural deterrent that helps keep the landscape healthier without harsh chemicals; salt- and heat-hardy from Karachi to Multan and Bahawalpur, neem shrugs off poor soils and blazing summers, asking only for sun and drainage; available in landscape-ready 5–7 ft specimens, our Planted & Guaranteed Neem Package includes site prep, premium compost, slow-release nutrients, drip emitter setup, first-year care plan, and a replacement warranty—order today and enjoy a durable, low-maintenance shade tree that pays you back with comfort, cleaner air, and an inherently pest-smart garden.',
    coverImage: 'assets/plants/neem1.jpg',
    images: [
      'assets/plants/neem1.jpg',
      'assets/plants/neem2.jpg',
      'assets/plants/neem3.jpg',
    ],
  ),
  Plant(
    id: 'guava',
    name: 'Guava Tree',
    price: 'PKR 3,600',
    shortDesc: 'Delicious fruit; compact habit for small yards.',
    longDesc:
        'Turn any sunny corner into a mini orchard with a Guava Tree—a fast-growing, sweetly aromatic fruiter that loves Pakistan’s climate and rewards you with vitamin-C–rich harvests for years; compact enough for modest yards yet productive in the ground or a large container (45–60 cm pot for dwarf types), guava is self-fertile (one tree can fruit) but sets even heavier with a second nearby; give it 6–8+ hours of sun, a well-drained loam, and deep, regular watering its first season to establish—then reduce to a consistent soak during warm months; prune after harvest to keep an open, airy canopy (great light and airflow = bigger, cleaner fruit), remove crossing shoots, and tip-pinch young growth to encourage branching; feed lightly in spring and midsummer with a balanced fruiting fertilizer plus micronutrients; space 3–4 m from walls/lines for semi-dwarfs, and protect young trees from hard frost up north; creamy white blossoms invite pollinators, and the crisp-to-buttery flesh is perfect fresh, juiced, or in chutneys—truly a zero-waste kitchen star; order our Fruit-Ready Guava Package—site prep, compost & micronutrients, expert planting, form-pruning, drip emitter setup, a first-year care plan, and a healthy-start guarantee—so you can enjoy fragrant shade and homegrown guavas with confidence.',
    coverImage: 'assets/plants/guava1.jpg',
    images: [
      'assets/plants/guava1.jpg',
      'assets/plants/guava2.png',
      'assets/plants/guava3.jpg',
    ],
  ),
  Plant(
    id: 'lemon',
    name: 'Lemon Tree',
    price: 'PKR 4,300',
    shortDesc: 'Citrusy scent, year-round interest, patio-friendly.',
    longDesc:
        'Turn everyday moments into something bright and refreshing with a Lemon Tree—an evergreen citrus that perfumes the air with blossoms and rewards you year-round with zesty, vitamin-C packed fruit; choose a reliable cultivar like Eureka or Lisbon for classic tang or Meyer for sweeter, thin-skinned lemons ideal for balconies, then plant in full sun (6–8+ hours) in well-drained, slightly acidic soil (raise the bed or use a large 50–75 L container with a gritty citrus mix if drainage is poor), water deeply but infrequently—let the top 3–5 cm dry before the next soak—and feed little and often with a balanced citrus fertilizer plus micros (Fe/Zn/Mg) for glossy leaves and consistent flowering; keep growth tidy with light tip-pruning after harvest, remove crossing shoots to improve airflow, mulch 5–8 cm to stabilize moisture (keep mulch off the trunk), and protect young trees from cold snaps or hot, desiccating winds with a breathable cover and regular watering; expect grafted trees to flower within the first season and fruit in 1–2 years, with best yields by year 3 (standard spacing 4–5 m in-ground; dwarfs 2.5–3 m), and manage common issues—leaf miner, scale, sooty mold—through good hygiene, sticky traps, horticultural oil, and strong airflow; whether you’re garnishing tea, curing seafood, baking lemon tarts, or making fresh lemonade, our Lemon Starter Package can handle the hard parts—site prep, soil amendment, first-year feeding schedule, and drip emitter setup—so you enjoy glossy foliage, fragrant blooms, and a steady supply of home-grown lemons with minimal fuss.',
    coverImage: 'assets/plants/lemon1.jpg',
    images: [
      'assets/plants/lemon1.jpg',
      'assets/plants/lemon2.jpg',
      'assets/plants/lemon3.jpg',
    ],
  ),
  Plant(
    id: 'mango',
    name: 'Mango Sapling',
    price: 'PKR 2,700',
    shortDesc: 'Beloved fruit tree; thrives in heat and sun.',
    longDesc:
        'Bring home the king of fruits with a Mango Sapling—a heat-loving, sun-hungry tree that thrives in Pakistan and rewards you with fragrant blossoms and luscious, vitamin-rich fruit for decades; plant a grafted variety (think Chaunsa, Sindhri, Anwar Ratol, Langra for classic flavor or Amrapali/Mallika for compact spaces) in 8+ hours of full sun, a well-drained loam (use a raised mound in heavier soils), and give deep, infrequent watering—soak thoroughly, then let the top few centimeters dry to prevent root issues; train the canopy low (first scaffold at ~60–80 cm), tip-prune after harvest to encourage branching and keep height manageable, and feed lightly at bud-break and mid-summer with a balanced, fruit-forward fertilizer plus key micros (Fe/Zn/Mg) for glossy leaves and strong flowering; in cooler zones, guard young trees from frost with mulch (7–10 cm), a breathable cover on cold nights, and wind protection; expect grafted trees to flower within 1–2 seasons and fruit in 2–3, with yields improving each year (self-fertile but better set with a second cultivar nearby); manage common pressures—fruit fly and sooty mold—through orchard hygiene, airflow, and gentle, labeled controls as needed; whether you plant in-ground with 4–6 m spacing or a 65–90 L container on a warm terrace, our Mango Starter Package makes it effortless: site prep, compost and micronutrients, expert planting and formative pruning, drip emitter setup, and a first-year care plan—so you can enjoy shade, perfume, and your own legendary mangoes sooner.',
    coverImage: 'assets/plants/mango1.jpg',
    images: [
      'assets/plants/mango1.jpg',
      'assets/plants/mango2.jpg',
      'assets/plants/mango3.jpg',
    ],
  ),
];

class PlantsPage extends StatefulWidget {
  final void Function(String) onNavigate;
  const PlantsPage({super.key, required this.onNavigate});

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _q.trim().toLowerCase();

    final filtered = query.isEmpty
        ? _catalog
        : _catalog.where((p) {
            final name = p.name.toLowerCase();
            final desc = p.shortDesc.toLowerCase();
            return name.contains(query) || desc.contains(query);
          }).toList();

    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;

    return ListView(
      children: [
        // Heading — compact on mobile
        ShellSection(
          child: Column(
            children: [
              Text(
                'Premium Plant Selection',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 28 : 32,
                  fontWeight: FontWeight.w800,
                  color: kForest,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Expertly chosen plants that thrive in your environment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: isMobile ? 13 : 14,
                ),
              ),
            ],
          ),
        ),

        // Search bar
        ShellSection(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? 900 : 720),
                  child: TextField(
                    controller: _searchCtrl,
                    textInputAction: TextInputAction.search,
                    onChanged: (v) => setState(() => _q = v),
                    onSubmitted: (v) => setState(() => _q = v),
                    decoration: InputDecoration(
                      hintText: 'Search plants or trees…',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _q.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Clear',
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _searchCtrl.clear();
                                setState(() => _q = '');
                              },
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: isMobile ? 10 : 14,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Showing ${filtered.length} of ${_catalog.length}',
                style: TextStyle(
                  color: const Color(0xFF777777),
                  fontSize: isMobile ? 12 : 13,
                ),
              ),
            ],
          ),
        ),

        // Responsive grid (4 on large, 3 on medium, 2 on mobile)
        ShellSection(
          child: LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final int cols = w >= 1200 ? 4 : (w >= 800 ? 3 : 2);
              final bool compact = cols == 2; // phone
              final double gap = compact ? 14 : 22;
              final double cardHeight = cols == 4
                  ? 356
                  : (cols == 3 ? 360 : 320);
              final double imageHeight = compact ? 88 : 120;

              if (filtered.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'No plants matched your search.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: gap,
                  mainAxisSpacing: gap,
                  mainAxisExtent:
                      cardHeight, // keeps layout stable/overflow-proof
                ),
                itemCount: filtered.length,
                itemBuilder: (_, i) => _PlantListCard(
                  plant: filtered[i],
                  imageHeight: imageHeight,
                  compact: compact,
                ),
              );
            },
          ),
        ),

        const Footer(),
      ],
    );
  }
}

/* --------------------------- LIST CARD (CTA) --------------------------- */

class _PlantListCard extends StatelessWidget {
  final Plant plant;
  final double imageHeight;
  final bool compact;
  const _PlantListCard({
    required this.plant,
    required this.imageHeight,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    return CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              plant.coverImage,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) => Container(
                height: imageHeight,
                color: const Color(0xFFEFEFEF),
                child: const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Name (2 lines on mobile)
          Text(
            plant.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: compact ? 15 : 16,
              fontWeight: FontWeight.w800,
              color: kForest,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 3),

          // Price
          const SizedBox(height: 1),
          Text(
            plant.price,
            style: const TextStyle(fontWeight: FontWeight.w800, color: kGreen),
          ),
          const SizedBox(height: 6),

          // Short description (2–3 lines)
          Text(
            plant.shortDesc,
            textAlign: TextAlign.justify,
            maxLines: compact ? 2 : 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF666666),
              height: compact ? 1.4 : 1.5,
              fontSize: compact ? 12.8 : 13.2,
            ),
          ),

          const Spacer(),

          // CTA
          Align(
            alignment: Alignment.centerLeft,
            child: PrimaryButton(
              label: 'Check Details',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PlantDetailsPage(plant: plant),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
