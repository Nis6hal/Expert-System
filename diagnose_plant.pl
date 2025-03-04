% Declare 'has_symptom/1' as a dynamic predicate
:- dynamic has_symptom/1.

% Facts about plant symptoms (empty initially)
% The symptoms will be asserted based on user input

% Rules for diagnosing plant problems (with more specific conditions)
diagnose(overwatering) :-
    has_symptom(wilting),
    has_symptom(wet_soil),
    not(has_symptom(dry_soil)),
    write('Diagnosis: Overwatering\n'),
    treatment(overwatering).

diagnose(underwatering) :-
    has_symptom(wilting),
    has_symptom(dry_soil),
    not(has_symptom(wet_soil)),
    write('Diagnosis: Underwatering\n'),
    treatment(underwatering).

diagnose(pest_infestation) :-
    has_symptom(pest_infestation),
    has_symptom(yellow_leaves),
    write('Diagnosis: Pest Infestation\n'),
    treatment(pest_infestation).

diagnose(nutrient_deficiency) :-
    has_symptom(yellow_leaves),
    has_symptom(weak_growth),
    not(has_symptom(pest_infestation)),
    write('Diagnosis: Nutrient Deficiency\n'),
    treatment(nutrient_deficiency).

diagnose(heat_stress) :-
    has_symptom(brown_spots),
    has_symptom(wilting),
    write('Diagnosis: Heat Stress\n'),
    treatment(heat_stress).

diagnose(fungal_infection) :-
    has_symptom(white_powder),
    has_symptom(brown_spots),
    write('Diagnosis: Fungal Infection\n'),
    treatment(fungal_infection).

diagnose(root_rot) :-
    has_symptom(wilting),
    has_symptom(wet_soil),
    has_symptom(root_rot),
    write('Diagnosis: Root Rot\n'),
    treatment(root_rot).

diagnose(leaf_drop) :-
    has_symptom(leaf_drop),
    has_symptom(wilting),
    write('Diagnosis: Leaf Drop\n'),
    treatment(leaf_drop).

diagnose(brittle_leaves) :-
    has_symptom(brittle_leaves),
    has_symptom(dry_soil),
    write('Diagnosis: Brittle Leaves\n'),
    treatment(brittle_leaves).

diagnose(leaf_curvature) :-
    has_symptom(leaf_curvature),
    has_symptom(brown_spots),
    write('Diagnosis: Leaf Curvature\n'),
    treatment(leaf_curvature).

% Extended rules for providing treatment suggestions
treatment(overwatering) :-
    write('Recommendation: Reduce watering frequency. Ensure proper drainage in the soil.\n').

treatment(underwatering) :-
    write('Recommendation: Increase watering frequency and ensure the plant is getting enough moisture.\n').

treatment(pest_infestation) :-
    write('Recommendation: Treat the plant with an insecticide. Remove any visibly infected parts.\n').

treatment(nutrient_deficiency) :-
    write('Recommendation: Consider fertilizing the plant with a balanced fertilizer rich in nitrogen and potassium.\n').

treatment(heat_stress) :-
    write('Recommendation: Move the plant to a cooler area, away from direct sunlight.\n').

treatment(fungal_infection) :-
    write('Recommendation: Remove infected leaves. Apply an antifungal treatment.\n').

treatment(root_rot) :-
    write('Recommendation: Check the roots and trim away any affected areas. Reduce watering.\n').

treatment(leaf_drop) :-
    write('Recommendation: Ensure proper watering. Check for any pest infestations.\n').

treatment(brittle_leaves) :-
    write('Recommendation: Increase humidity and water the plant more regularly.\n').

treatment(leaf_curvature) :-
    write('Recommendation: Adjust watering habits and avoid overwatering. Consider a change in pot size.\n').

% Helper predicate to read user input and check if it's yes or no
ask_question(Question) :-
    write(Question), nl,
    read_line_to_string(user_input, Response),
    (Response == "yes" ; Response == "y").

% Loop to gather symptoms from the user
gather_symptoms :-
    % Only assert the symptom if user answers yes
    (ask_question('Does your plant have yellow leaves? (yes/no): ') -> assert(has_symptom(yellow_leaves)); true),
    (ask_question('Is the plant wilting? (yes/no): ') -> assert(has_symptom(wilting)); true),
    (ask_question('Is there visible pest infestation? (yes/no): ') -> assert(has_symptom(pest_infestation)); true),
    (ask_question('Is the soil dry? (yes/no): ') -> assert(has_symptom(dry_soil)); true),
    (ask_question('Is the soil wet? (yes/no): ') -> assert(has_symptom(wet_soil)); true),
    (ask_question('Does the plant have brown spots on leaves? (yes/no): ') -> assert(has_symptom(brown_spots)); true),
    (ask_question('Does the plant have weak or stunted growth? (yes/no): ') -> assert(has_symptom(weak_growth)); true),
    (ask_question('Does the plant have white powder on leaves? (yes/no): ') -> assert(has_symptom(white_powder)); true),
    (ask_question('Is there root rot or bad smell from the roots? (yes/no): ') -> assert(has_symptom(root_rot)); true),
    (ask_question('Is the plant shedding leaves excessively? (yes/no): ') -> assert(has_symptom(leaf_drop)); true),
    (ask_question('Are the leaves brittle? (yes/no): ') -> assert(has_symptom(brittle_leaves)); true),
    (ask_question('Are the leaves curved unnaturally? (yes/no): ') -> assert(has_symptom(leaf_curvature)); true).

% Main predicate to diagnose the plant based on symptoms
diagnose_plant :-
    % Clear any old symptoms from previous runs
    retractall(has_symptom(_)),
    
    % Gather current symptoms
    gather_symptoms, 

    % Try diagnosing based on the gathered symptoms
    (diagnose(_) -> true; write('Sorry, we could not diagnose the plant based on the provided symptoms.\n')).

