function getCustomRoundoff(roundoffVal, DefaultRound) {
    var result = (Math.ceil(Number(roundoffVal) / DefaultRound)) * DefaultRound;
    return result;
}