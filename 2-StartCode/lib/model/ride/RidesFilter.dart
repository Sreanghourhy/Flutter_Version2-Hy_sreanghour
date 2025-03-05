class RidesFilter {
  final bool acceptsPets;

  const RidesFilter({
    this.acceptsPets = false, required bool petsAccepted,
  });
}

enum RideSortType { departureTime, duration, availableSeats }
