// import { experimental_AstroContainer as AstroContainer } from "astro/container";
import { afterEach, describe, expect, it, vi } from "vitest";
import { fetchInitialVoteCounts, updateAPIVotes } from "../src/scripts/voting.js";

describe("Function to fetch initial vote counts", () => {
    afterEach(() => {
        // Restore all mocks after each test to clean up
        vi.resetAllMocks();
    });

    it("should update vote counts if data present on successful fetch", async () => {
        const voteCounts = {
            layer1: 0,
            layer2: 0,
            layer3: 0,
            layer4: 0,
        };
        const mockResult = {
            layer1: 100,
            layer2: 150,
            layer3: 200,
            layer4: 250,
        };

        vi.spyOn(global, "fetch").mockResolvedValue({
            json: () => Promise.resolve(mockResult),
        });

        // Call the function
        const response = await fetchInitialVoteCounts(voteCounts);

        // Assert fetch was called correctly
        expect(fetch).toHaveBeenCalled();

        // Check the updates on voteCounts object
        expect(response).toEqual(mockResult);
    });

    it("should output error if no data from successful fetch", async () => {
        const voteCounts = {
            layer1: 0,
            layer2: 0,
            layer3: 0,
            layer4: 0,
        };
        const mockResult = null;

        vi.spyOn(console, "error");
        vi.spyOn(global, "fetch").mockResolvedValue({
            json: () => Promise.resolve(mockResult),
        });

        // Call the function
        await fetchInitialVoteCounts(1, voteCounts);

        // Assert fetch was called correctly
        expect(fetch).toHaveBeenCalled();

        // Check the updates on voteCounts object
        expect(console.error).toHaveBeenCalledWith("No data found for the specified round");
    });

    it("should output error on failed fetch", async () => {
        const voteCounts = {
            layer1: 0,
            layer2: 0,
            layer3: 0,
            layer4: 0,
        };

        vi.spyOn(console, "error");
        vi.spyOn(global, "fetch").mockResolvedValue({
            json: () => Promise.reject(new Error("Fetch failed")),
        });

        // Call the function
        await fetchInitialVoteCounts(1, voteCounts);

        // Assert fetch was called correctly
        expect(fetch).toHaveBeenCalled();

        // Check the updates on voteCounts object
        expect(console.error).toHaveBeenCalledWith("Error fetching initial vote counts:", new Error("Fetch failed"));
    });
});

describe("Function to update votes using API", () => {
    afterEach(() => {
        // Restore all mocks after each test to clean up
        vi.restoreAllMocks();
    });

    it("should reset count on successful fetch with non-zero votes", async () => {
        const accumulatedVotes = { layer1: 10, layer2: 20, layer3: 30, layer4: 40 };
        const expectedResult = { layer1: 0, layer2: 0, layer3: 0, layer4: 0 };

        vi.spyOn(global, "fetch").mockResolvedValue({
            ok: true,
        });

        const response = await updateAPIVotes(accumulatedVotes);

        expect(fetch).toHaveBeenCalled();

        expect(response).toEqual(expectedResult);
    });

    it("should output error on failed fetch", async () => {
        const accumulatedVotes = { layer1: 0, layer2: 20, layer3: 30, layer4: 40 };

        vi.spyOn(console, "error");
        vi.spyOn(global, "fetch").mockRejectedValue(new Error("Fetch failed"));

        await updateAPIVotes(accumulatedVotes);

        expect(console.error).toHaveBeenCalledWith("Error updating vote counts:", new Error("Fetch failed"));
    });

    it("should return original votes and does not call API if all votes are 0", async () => {
        const accumulatedVotes = { layer1: 0, layer2: 0, layer3: 0, layer4: 0 };
        const mockFetch = vi.spyOn(global, "fetch");

        const result = await updateAPIVotes(accumulatedVotes);

        expect(mockFetch).not.toHaveBeenCalled();
        expect(result).toEqual(accumulatedVotes);
    });

    it("should output error if API response is not ok", async () => {
        const accumulatedVotes = { layer1: 5, layer2: 0, layer3: 0, layer4: 0 };

        vi.spyOn(console, "error");
        vi.spyOn(global, "fetch").mockResolvedValue({
            ok: false,
        });

        await updateAPIVotes(accumulatedVotes);

        expect(console.error).toHaveBeenCalledWith("Error updating vote counts:", new Error("API update failed"));
    });
});
