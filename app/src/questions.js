export const quizQuestions = [
  {
    questionText: "How do you usually order food at the hawker centre?",
    options: [
      "I just queue and give the owners a nod - they already know my usual",
      "I dabao ahead on the app, and skip the queue to collect",
      "I order a delivery straight to my house",
    ],
    lottieFileUrl: "lottie/Questions Page/Q1 Scene.json",
  },
  {
    questionText: "Your ideal weekend includes...",
    options: [
      "A morning walk by East Coast, then kopi with my family",
      "Cafe-hopping, people-watching, and updating my socials",
      "Bouncing between community events or volunteering",
    ],
    lottieFileUrl: "lottie/Questions Page/Q2 Scene.json",
  },
  {
    questionText: "You're working on a group project and hit a bump. You ...",
    options: [
      "Take the strategic approach- assign tasks based on everyone's strengths.",
      "Have an open conversation to hear everyone out before solving it together",
      "Start by breaking the tension - crack a few jokes to lighten the mood.",
    ],
    lottieFileUrl: "lottie/Questions Page/Q3 Scene.json",
  },
  {
    questionText: "What music gets you in the National Day spirit?",
    options: [
      "Jamming to 'OOs hits by artists like Kit Chan and Taufik Batisah on YouTube",
      "Listening to lo-fi NDP beats on Spotify",
      "Tuning into old-school 80s radio tunes, or listening to mixtapes on my Walkman",
    ],
    lottieFileUrl: "lottie/Questions Page/Q4 Scene.json",
  },
  {
    questionText: "What's your attitude towards technology and innovation?",
    options: [
      "If it makes life easier, I'm all for it. Bring on automation!",
      "I'm tech-capable, but I'm not running after every new trend",
      "Honestly, I'm happy with how things are. No need to change what works!",
    ],
    lottieFileUrl: "lottie/Questions Page/Q5 Scene.json",
  },
  {
    questionText: "At National Day Parade, you're most excited about ...",
    options: [
      "The Red Lions' freefall - shiok to watch every year!",
      "Singing along to 'This is Home, truly ... ' with everyone",
      "Sharing parade highlights online, and keeping an eye out for this year's NDP meme",
    ],
    lottieFileUrl: "lottie/Questions Page/Q6 Scene.json",
  },
  {
    questionText:
      "The trip finally made it out of the group chat! How do you prep for the trip?",
    options: [
      "I book everything in advance and plan a full itinerary.",
      "I go with the flow - I bring the energy and good vibes",
      "I split the planning, suggesting unique local spots and hidden gems",
    ],
    lottieFileUrl: "lottie/Questions Page/Q7 Scene.json",
  },
  {
    questionText: "What's most important to you in life?",
    options: [
      "Stability and achieving life milestones like housing, career and family",
      "Doing something meaningful and original, even if it's unconventional",
      "Making a positive impact, especially for future generations",
    ],
    lottieFileUrl: "lottie/Questions Page/Q8 Scene.json",
  },
];

/*
Pioneer Hustlers  0
Nation Builders   1
Trend Setters     2
Global Citizens   3
Culture Curators  4
Next-Gen Creators 5
*/

// --- Persona Definitions ---
// Make sure these indices match your intended persona order (as used in the mapping image)
export const ERAS = [
  "Pioneer Hustlers", // Index 0
  "Nation Builders", // Index 1
  "Trend Setters", // Index 2
  "Global Citizens", // Index 3
  "Culture Curators", // Index 4
  "Next-Gen Creators", // Index 5
];
export const questionScores = [
  // Q1: How do you usually order food at the hawker centre?
  // Opt 0: Pioneer Hustler (0), Opt 1: Next-Gen Creators (5), Opt 2: Trend Setter (2)
  [0, 5, 2],

  // Q2: Your ideal weekend includes...
  // Opt 0: Nation Builder (1), Opt 1: Culture Curator (4), Opt 2: Pioneer Hustler (0)
  [1, 4, 0],

  // Q3: You're working on a group project and hit a bump. You ...
  // Opt 0: Global Citizen (3), Opt 1: Pioneer Hustler (0), Opt 2: Trend Setter (2)
  [3, 0, 2],

  // Q4: What music gets you in the National Day spirit?
  // Opt 0: Nation Builder (1), Opt 1: Culture Curator (4), Opt 2: Trend Setter (2)
  [1, 4, 2],

  // Q5: What's your attitude towards technology and innovation?
  // Opt 0: Next-Gen Creators (5), Opt 1: Global Citizen (3), Opt 2: Pioneer Hustler (0)
  [5, 3, 0],

  // Q6: At National Day Parade, you're most excited about ...
  // Opt 0: Global Citizen (3), Opt 1: Nation Builder (1), Opt 2: Next-Gen Creator (5)
  [3, 1, 5],

  // Q7: The trip finally made it out of the group chat! How do you prep for the trip?
  // Opt 0: Global Citizen (3), Opt 1: Trend Setter (2), Opt 2: Culture Curator (4)
  [3, 2, 4],

  // Q8: What's most important to you in life?
  // Opt 0: Nation Builder (1), Opt 1: Culture Curator (4), Opt 2: Next-Gen Creators (5)
  [1, 4, 5],
];

//Collect the indexs of the options they collect and tabulate in a hashmap
//get last ans to settle conflict
export function calculateERAScores(userAnswers) {
  //init hashmap
  const scores = {};
  for (let i = 0; i <= 5; i++) {
    scores[i] = 0; // You can assign any value here
  }
  //tabulate score
  for (let i = 0; i < userAnswers.length; i++) {
    //get the right persona index from the index of option by looking in questionScores
    let persona = questionScores[i][userAnswers[i]];
    console.log("user picked" + userAnswers[i]);
    console.log("corresponding to" + persona);
    scores[persona] += 1;
  }
  console.log(scores);
  //get the overall persona
  //check if there is conflict
  const getMax = (object) => {
    return Object.keys(object).filter((x) => {
      return object[x] == Math.max.apply(null, Object.values(object));
    });
  };
  let maxArray = getMax(scores);
  //console.log(maxArray);
  //if only 1 we return the index of the persona
  if (maxArray.length === 1) {
    return maxArray[0];
  }
  //if getMax len > 1, then there is conflict we return most recent highest
  else if (maxArray.length > 1) {
    //we do the search
    //reverse the userAnswers
    for (let i = userAnswers.length - 1; i >= 0; i--) {
      const candidate = userAnswers[i];
      if (maxArray.includes(String(candidate))) {
        return candidate;
      }
    }
  } else {
    //error, means empty
    console.log("Error!! array passed in is empty");
    return -1;
  }
}
