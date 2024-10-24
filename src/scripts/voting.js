// Function to fetch initial vote counts
export async function fetchInitialVoteCounts(voteCounts) {
    try {
        /*
        UPDATE VOTING ROUND HERE
        */
        const response = await fetch(`https://8ofnowhrs8.execute-api.ap-southeast-1.amazonaws.com/voting?round=1`);
        const data = await response.json();

        if (data) {
            // Update individual properties
            voteCounts.layer1 = data.layer1;
            voteCounts.layer2 = data.layer2;
            voteCounts.layer3 = data.layer3;
            voteCounts.layer4 = data.layer4;

            return voteCounts;
        } else {
            console.error("No data found for the specified round");
            return;
        }
    } catch (error) {
        console.error("Error fetching initial vote counts:", error);
    }
}

// Function to update API with accumulated votes
export async function updateAPIVotes(accumulatedVotes) {
    const updates = Object.entries(accumulatedVotes).filter(([_, count]) => count > 0);

    if (updates.length === 0) return accumulatedVotes;

    const body = {
        /* 
        UPDATE VOTING ROUND HERE
        */
        round: 1,
        votes: {
            layer1: accumulatedVotes.layer1 || 0,
            layer2: accumulatedVotes.layer2 || 0,
            layer3: accumulatedVotes.layer3 || 0,
            layer4: accumulatedVotes.layer4 || 0,
        },
    };

    try {
        const response = await fetch(`https://8ofnowhrs8.execute-api.ap-southeast-1.amazonaws.com/voting`, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(body),
        });

        if (!response.ok) {
            throw new Error("API update failed");
        }

        // Reset accumulated votes after successful update
        Object.keys(accumulatedVotes).forEach((key) => {
            accumulatedVotes[key] = 0;
        });
        return accumulatedVotes;
    } catch (error) {
        console.error("Error updating vote counts:", error);
    }
}
