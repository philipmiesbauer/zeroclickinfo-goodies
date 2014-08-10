package DDG::Goodie::DaysBetween;
# ABSTRACT: Give the number of days between two given dates.

use DDG::Goodie;
with 'DDG::GoodieRole::Dates';

triggers start => "days between", "days", "daysbetween", "days_between";

zci is_cached => 1;
zci answer_type => "days_between";

primary_example_queries 'days between 01/31/2000 01/31/2001';
secondary_example_queries 'days between 01/31/2000 01/31/2001 inclusive';
description 'calculate the number of days between two dates';
name 'DaysBetween';
code_url 'https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/DaysBetween.pm';
category 'calculations';
topics 'everyday';
attribution github => ['http://github.com/JetFault', 'JetFault'];

my $date_regex = date_regex();

handle remainder => sub {
    return unless $_ =~ qr/^($date_regex) (?:(?:and|to) )?($date_regex)/i;
    
    my $date1 = parse_string_to_date($1);
    my $date2 = parse_string_to_date($2);
    my $difference = $date1->delta_days($date2);
    my $daysBetween = abs($difference->in_units('days'));
    my $inclusive = '';
    if(/inclusive/) {
        $daysBetween += 1;
        $inclusive = ', inclusive';
    }
    my $startDate = $date1->strftime("%d %b %Y");
    my $endDate = $date2->strftime("%d %b %Y");
    return "There are $daysBetween days between $startDate and $endDate$inclusive.";
};

1;
